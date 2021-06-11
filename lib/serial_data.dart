import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:my_app/UI/MyDrawer.dart';
import 'Tools/User.dart';
import 'Tools/helper.dart';
import 'UI/MyAppBar.dart';
import 'UI/MyDrawer.dart';
import './read.dart';
import './Testing.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:math' as math;
import 'Tools/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bundler/stub_js.dart' if (dart.library.js) 'dart:js' as js;



class serial_data extends StatefulWidget {
  final User user;
  final String patient;
  final DocumentReference reference;
  final String sensor;
  final BluetoothConnection connection;


  serial_data({@required this.user, @required this.patient, @required this.reference, @required this.sensor, @required this.connection});

  @override
  State createState() {
    return _serial_data(user, patient, reference, sensor, connection);
  }
}

class _serial_data extends State<serial_data> {
  final User user;
  final String patient;
  final DocumentReference reference;
  final String sensor;
  final BluetoothConnection connection;


  _serial_data(this.user, this.patient, this.reference, this. sensor, this.connection);

  DateTime selected_DT;
  double seleted_measurement;
  int selected_index;
  String selected_annotation = "";
  double y_up = 50;
  double y_down = 20;

  var rng = new math.Random();
  Timer timer;
  bool recording = false;
  double reading = 0;
  String record_button = "Start Recording";
  String reading_ID;
  String annotation_S = "Description";
  bool left = false;

  ZoomPanBehavior zooming;
  TrackballBehavior trackball;
  TooltipBehavior tooltip;
  SelectionBehavior selection;
  DateTimeAxis xAxis;
  MarkerSettings markerSettings;
  ChartSeriesController _chartSeriesController;
  List<_MeasuredData> data = [];

  int bytePackage = 0;
  Uint8List byteBuffer = Uint8List(4);



  @override void initState() {
    Uint8List temp;
    super.initState();
    if (connection != null) {
      connection.input.listen((Uint8List bytesinput) {
        // print('Data incoming: ${data}');
        // print("init listen");
        processByte(bytesinput);

        // connection.output.add(data); // Sending data

        // if (ascii.decode(data).contains('!')) {
        //   connection.finish(); // Closing connection
        //   print('Disconnecting by local host');
        // }
      });
    } else if (sensor == "Chrome Web Serial API"){
      Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        Uint8List new_data = getFromJS("value");
        if ( new_data != temp ) {
          temp = new_data;
          processByte(new_data);
        }
        return;
      });


    } else {
      Timer.periodic(const Duration(milliseconds: 1000), _updateData);

    }


  }

  @override
  void dispose() {
    left = true;
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    trackball = TrackballBehavior(enable: true);
    tooltip = TooltipBehavior(enable: true);
    selection = SelectionBehavior(
        enable: true,
        selectedColor: Colors.red,
        selectedBorderWidth: 1,
        unselectedColor: Colors.grey,
        unselectedBorderWidth: 1);
    zooming = ZoomPanBehavior(
      enableSelectionZooming: false,
      enableDoubleTapZooming: false,
      enablePinching: true,
      enablePanning: true,
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
      // maximumZoomLevel: 0.4
    );
    xAxis = DateTimeAxis(
      // dateFormat: DateFormat.y(),
        rangePadding: ChartRangePadding.additional,
        intervalType: DateTimeIntervalType.seconds,
        interval: 1
      // visibleMaximum: data[3].year
    );
    markerSettings = MarkerSettings(
      isVisible: true
    );

    // Show a loader until FlutterFire is initialized
    if (data.length<2) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(sensor + " Live data"),
        ),
        body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                //Initialize the spark charts widget
                child: Text ("Current Reading:  " + reading.round().toString() +" mV")
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text(record_button),
                  onPressed: () {
                    _newRecording();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (recording) {
                          return Colors.red;
                        } else {
                          return Colors.green;
                        }// Use the component's default.
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Initialize the chart widget
          SfCartesianChart(
              title: ChartTitle(text: "Patient  ID " + patient),
              primaryYAxis: NumericAxis(
                labelFormat: '{value}%',
                minimum: y_down,
                maximum: y_up,
                  // numberFormat: NumberFormat.
              ),
              primaryXAxis: xAxis,
              trackballBehavior: trackball,
              zoomPanBehavior: zooming,
              tooltipBehavior: tooltip,
              selectionType: SelectionType.point,

              onSelectionChanged: (SelectionArgs args) {
                print(args.pointIndex);
                setState(() {
                  selected_DT = data[args.pointIndex].time;
                  seleted_measurement = data[args.pointIndex].measurement;
                  selected_index = args.pointIndex;
                  selected_annotation = data[args.pointIndex].info;
                });
              },
              series: <ChartSeries<_MeasuredData, DateTime>>[
                LineSeries<_MeasuredData, DateTime>(
                  enableTooltip: false,
                  selectionBehavior: selection,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  dataSource: data,
                  xValueMapper: (_MeasuredData datapoint, _) => datapoint.time,
                  yValueMapper: (_MeasuredData datapoint, _) => datapoint.measurement,
                  // Map the data label text for each point from the data source
                  dataLabelMapper: (_MeasuredData datapoint, _) => datapoint.info,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true
                  ),
                  markerSettings: markerSettings,
                  name: 'Measurement',
                )
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text('View all'),
                  onPressed: () {
                    zooming.reset();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text('Scroll to end'),
                  onPressed: () {
                    // zooming.zoomIn();
                    zooming.zoomToSingleAxis(xAxis,0.99,10/data.length);
                    zooming.panToDirection('right');

                  },

                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    //Initialize the spark charts widget
                    child: ElevatedButton(
                      child: Text('Up'),
                      onPressed: () {
                        // zooming.reset();
                        // zooming.zoomMode.index.
                        // zooming.zoomIn();
                        setState(() {
                          y_up = y_up+5;
                          y_down = y_down+5;

                        });;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    //Initialize the spark charts widget
                    child: ElevatedButton(
                      child: Text('Down'),
                      onPressed: () {
                        // zooming.reset();
                        // zooming.zoomOut();
                        setState(() {
                          y_up = y_up-5;
                          y_down = y_down-5;
                        });;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            //Initialize the spark charts widget
            child: ElevatedButton(
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      annotation_S = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Select data in recording and add annotation here...',
                  ),
                )
            ),
          ),
        Padding(
            padding: const EdgeInsets.all(12.0),
            //Initialize the spark charts widget
            child: Row(
              children: [
                Text("Selected Time: "),
                Text(selected_DT.toString()),
              ],
            ),
        ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            //Initialize the spark charts widget
            child: Row(
              children: [
                Text("Selected annotation: "),
                Text(selected_annotation),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text('Quick Annotate'),
                  onPressed: () {
                    return (
                        showDialog(
                            context: context,
                            builder: (ctx) =>
                                AlertDialog(
                                  title: Text("Quick Annotation "),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Text("Drug administered"),
                                        onPressed: () {
                                          _updateAnnotation("Drug administered");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Sample taken"),
                                        onPressed: () {
                                          _updateAnnotation("Sample taken");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Pain"),
                                        onPressed: () {
                                          _updateAnnotation("Pain");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Procedure"),
                                        onPressed: () {
                                          _updateAnnotation("Procedure");
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ))
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text('Annotate with text'),
                  onPressed: () {
                    _updateAnnotation(annotation_S);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            //Initialize the spark charts widget
            child: ElevatedButton(
              child: Text('Clear'),
              onPressed: () {
                _updateAnnotation("");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.red;
                  },
                ),
              ),
            ),
          ),
        ])
        )
    );
  }


  void processByte(Uint8List input) async {
    for (int i = 0; i < input.length; i++) {
      byteBuffer[bytePackage] = input[i];
      bytePackage++;

      if (bytePackage == 4) {
        // print(Endian.host == Endian.little);

        ByteData byteData = ByteData.sublistView(byteBuffer);


        int channel_1_raw = byteData.getUint16(0, Endian.big);
        int channel_2_raw = byteData.getUint16(2, Endian.big);

        if (channel_1_raw > 1023 || channel_2_raw > 1023) {
          byteBuffer[0] = input[i];
          bytePackage = 1;
          continue;
        } else {
          bytePackage = 0;
        }

        double channel_1 = channel_1_raw/1024*10+30;
        double channel_2 = channel_2_raw/1024*10+30;

        print("Channel 1: " + channel_1.toString() + " Channel 2: " + channel_2.toString());
        // Uint16List sixteenBitList = byteBuffer.buffer.asUint16List();
        // print(sixteenBitList);


        DateTime timestamp = new DateTime.now();
        if (!left) {
          setState(() {
            reading = channel_1;
          });
        }
        data.add(_MeasuredData(timestamp, channel_1, ""));
        _chartSeriesController.updateDataSource(
          addedDataIndexes: <int>[data.length - 1],
        );
        if (recording) {

          reference.collection("recordings").doc(reading_ID).collection("time_series").doc(timestamp.toString()).set({
            'DateTime_stamp': timestamp,
            'measurement': channel_1,
            'annotation': null
          });
        }

      }
    }
  }



  void _newRecording() {
    if (!recording) {
      DateTime start_time = new DateTime.now();
      reading_ID = DateFormat('yyyy-MM-dd  HH:mm:ss').format(start_time);
      reference.collection("recordings").doc(reading_ID).set({
        'DateTime_start': start_time, // John Doe
        'sensor': sensor, // Stokes and Sons
      })
          .then(
              (value) => {

              data[data.length -1].info = "Start",
        _chartSeriesController.updateDataSource(
        updatedDataIndexes: <int>[data.length -1],
      ),


              reference.collection("recordings").doc(reading_ID).collection("time_series").doc(start_time.toString()).set({
              'DateTime_stamp': start_time,
              'measurement': reading,
              'annotation': "Start"
              }).then((value) => print("User Added"))
                  .catchError((error) => print("Failed to add user: $error"))


            // print("Reading created, ID " + value.id)
            }
      )
          .catchError((error) => print("Failed to add reading: $error"));

      recording = true;
      setState(() {
        record_button = "Stop Recording";
      });
    } else {
      data[data.length -1].info = "End";
      _chartSeriesController.updateDataSource(
        updatedDataIndexes: <int>[data.length -1],
      );
      reference.collection("recordings").doc(reading_ID).collection("time_series").doc(data[data.length -1].time.toString()).update({
        'annotation': "End"});
      recording = false;
      setState(() {
        record_button = "Start Recording";
      });

    }

  }

  void _updateAnnotation(String input) {
    data[selected_index].info = input;
    _chartSeriesController.updateDataSource(
      updatedDataIndexes: <int>[selected_index],
    );
    setState(() {
      selected_annotation = input;
    });
    reference.collection("recordings").doc(reading_ID).collection("time_series").doc(selected_DT.toString()).update({
      'annotation': input});
    }

  void _updateData(Timer timer) {
    if (left) {
      timer.cancel();
      return;
    }

    DateTime timestamp = new DateTime.now();
    double generated = 30 + 10 * math.sin(timestamp.second * 24 * (math.pi / 180.0)) + 5*rng.nextDouble();
    setState(() {
      reading = generated;
    });
    data.add(_MeasuredData(timestamp, generated, ""));
    _chartSeriesController.updateDataSource(
      addedDataIndexes: <int>[data.length - 1],
    );
    if (recording) {

      reference.collection("recordings").doc(reading_ID).collection("time_series").doc(timestamp.toString()).set({
        'DateTime_stamp': timestamp,
        'measurement': generated,
        'annotation': null
      });
    }
  }
}

class _MeasuredData {
  _MeasuredData(this.time, this.measurement, this.info);
  final DateTime time;
  final double measurement;
  String info;
}


//
//   @override
//   Widget build(BuildContext context) {
//
//     return Material(
//       child: Scaffold (
//         appBar: MyAppBar(title: Text("Patient " + patient), user: user),
//         drawer: MyDrawer(),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ElevatedButton(
//                   child: Text('Live data'),
//                   onPressed: (){
//                     print(user.userID);
//                     // push(context, Read(user: user));
//                     push(context, MyHomePage(user: user));
//                   }//
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ElevatedButton(
//                   child: Text('History'),
//                   onPressed: (){
//                     print(user.userID);
//                     // push(context, Read(user: user));
//                     push(context, MyHomePage(user: user));
//                   }//
//               ),
//             ),
//           ],
//         )
//
//       )
//     );
//
//
//
//
//     // return Scaffold(
//       // drawer: Drawer(
//       //   child: ListView(
//       //     padding: EdgeInsets.zero,
//       //     children: <Widget>[
//       //       DrawerHeader(
//       //         child: Text(
//       //           'Menu',
//       //           style: TextStyle(color: Colors.white),
//       //         ),
//       //         decoration: BoxDecoration(
//       //           color: Color(COLOR_PRIMARY),
//       //         ),
//       //       ),
//       //       ListTile(
//       //         title: Text(
//       //           'Logout',
//       //           style: TextStyle(color: Colors.black),
//       //         ),
//       //         leading: Transform.rotate(
//       //             angle: pi/1,
//       //             child: Icon(Icons.exit_to_app, color: Colors.black)),
//       //         onTap: () async {
//       //           // user.active = false;
//       //           // user.lastOnlineTimestamp = Timestamp.now();
//       //           await auth.FirebaseAuth.instance.signOut();
//       //           MyAppState.currentUser = null;
//       //           pushAndRemoveUntil(context, LoginScreen(), false);
//       //         },
//       //       ),
//       //     ],
//       //   ),
//       // ),
//
//       // appBar: AppBar(
//       //   title: Text(
//       //     'Connected Patients',
//       //     style: TextStyle(color: Colors.black),
//       //   ),
//       //   iconTheme: IconThemeData(color: Colors.black),
//       //   backgroundColor: Colors.white,
//       //   centerTitle: true,
//       // ),
//
//       // body: Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     mainAxisSize: MainAxisSize.max,
//       //     crossAxisAlignment: CrossAxisAlignment.center,
//       //     children: <Widget>[
//       //       // displayCircleImage(user.profilePictureURL, 125, false),
//       //       // Padding(
//       //       //   padding: const EdgeInsets.all(8.0),
//       //       //   child: Text(user.firstName),
//       //       // ),
//       //       Padding(
//       //         padding: const EdgeInsets.all(8.0),
//       //         child: Text(user.email),
//       //       ),
//       //
//       //       // Padding(
//       //       //   padding: const EdgeInsets.all(8.0),
//       //       //   child: Text(user.userID),
//       //       // ),
//       //     ],
//       //   ),
//       // ),
//     // );
//   }
// }