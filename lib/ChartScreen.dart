import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/UI/MyDrawer.dart';
import 'Tools/User.dart';
import 'Tools/helper.dart';
import 'UI/MyAppBar.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:math' as math;
import 'dart:typed_data';



class ChartScreen extends StatefulWidget {
  final User user;
  final String patient;
  final DocumentReference reference;
  final String sensor;
  final String document_name;
  final BluetoothConnection connection;

  ChartScreen({@required this.user, @required this.patient, @required this.reference, @required this.sensor, @required this.document_name, this.connection});

  @override
  State createState() {
    return _ChartScreen(user, patient, reference, sensor, document_name, connection);
  }
}

class _ChartScreen extends State<ChartScreen> {
  final User user;
  final String patient;
  final DocumentReference reference;
  final String sensor;
  final String document_name;
  final BluetoothConnection connection;

  _ChartScreen(this.user, this.patient, this.reference, this.sensor, this.document_name, this.connection);

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
  bool auto_scroll = false;

  ZoomPanBehavior zooming;
  TrackballBehavior trackball;
  TooltipBehavior tooltip;
  SelectionBehavior selection;
  DateTimeAxis xAxis;
  MarkerSettings markerSettings;
  ChartSeriesController _chartSeriesController;
  // final List<_MeasuredData> dataPoints = [_MeasuredData(DateTime.now(), 30 + 10 * math.sin(DateTime.now().second * 24 * (math.pi / 180.0)), "")];
  final List<_MeasuredData> dataPoints = [];
  StreamSubscription<QuerySnapshot> streamSubscription;

  bool live_data_mode = false;

  int bytePackage = 0;
  Uint8List byteBuffer = Uint8List(4);

  // Set default `_initialized` and `_error` state to false
  bool _error = false;
  bool _initialized = false;

  @override void initState() {
    Uint8List temp;
    if (document_name == "NONE") {
      live_data_mode = true;
    }

    if (connection != null) {
      print("Listening to byte stream");
      connection.input.listen((Uint8List bytesinput) {
        processByte(bytesinput);
      });
    } else if (sensor == "Chrome Web Serial API"){
      print("Chrome serial API");
      Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        Uint8List new_data = getFromJS("value");
        if ( new_data != temp ) {
          temp = new_data;
          processByte(new_data);
        }
        return;
      });

    } else if (live_data_mode) {
      print("Live data mode");
      Timer.periodic(
          const Duration(milliseconds: 1000), _updateData);
    } else {
      print("Loading data history");
      loadData();
    }
    super.initState();

  }

  @override
  void dispose() {
    left = true;
    streamSubscription.cancel();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    trackball = TrackballBehavior(enable: false);
    tooltip = TooltipBehavior(enable: false);
    selection = SelectionBehavior(
        enable: true,
        selectedColor: Colors.red,
        selectedBorderWidth: 1,
        unselectedColor: Colors.grey,
        unselectedBorderWidth: 1
    );
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
      isVisible: false
    );

    if (_error) {
      return MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 25,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Failed to load history!',
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                    ],
                  )),
            ),
          ));
    } else
    // Show a loader until FlutterFire is initialized
    if (dataPoints.length<2 || !live_data_mode&& !_initialized) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(sensor + (live_data_mode ? " Live data" : " Recording history")),
        ),
        body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   //Initialize the spark charts widget
              //   child: Text ("Current Reading:  " + reading.round().toString() +" mV")
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                //Initialize the spark charts widget
                child: live_data_mode? ElevatedButton(
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
                ) :
                ElevatedButton(
                  child: Text('Delete recording'),
                  onPressed: () {
                    return (
                        showDialog(
                            context: context,
                            builder: (ctx) =>
                                AlertDialog(
                                  title: Text("Confirm deleting history " +
                                      document_name.toString()),
                                  content: Text(
                                      "This action cannot be recovered."),
                                  actions: [
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {

                                        reference.collection("time_series").get().then((snapshot) {
                                          for (DocumentSnapshot ds in snapshot.docs){
                                            ds.reference.delete();
                                          }
                                        });
                                        reference.delete();
                                        int count = 0;
                                        Navigator.popUntil(context, (route) {
                                          return count++ == 2;
                                        });
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ))
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Colors.red;
                      },
                    ),
                  ),
                )
                ,
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
                print("Selected Index: ");
                print(args.pointIndex ?? "");
                setState(() {
                  selected_DT = dataPoints[args.pointIndex].time;
                  seleted_measurement = dataPoints[args.pointIndex].measurement;
                  selected_index = args.pointIndex;
                  selected_annotation = dataPoints[args.pointIndex].info;
                });
              },
              series: <ChartSeries<_MeasuredData, DateTime>>[
                LineSeries<_MeasuredData, DateTime>(
                  enableTooltip: false,
                  selectionBehavior: selection,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  dataSource: dataPoints,
                  xValueMapper: (_MeasuredData datapoint, _) => datapoint.time,
                  yValueMapper: (_MeasuredData datapoint, _) => datapoint.measurement,
              // Duration of series animation, disable the animation by setting this property to 0.
              animationDuration: 0,
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
                    setState(() {
                      auto_scroll = false;
                    });
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
                    scroll_to_end();
                    if (auto_scroll){
                      setState(() {
                        auto_scroll = false;
                      });
                    } else {
                      setState(() {
                        auto_scroll = true;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (auto_scroll) {
                          return Colors.green;
                        } else {
                          return Colors.blue;
                        }// Use the component's default.
                      },
                    ),
                  ),

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

  void loadData() async {
    try {
      await reference.collection("time_series").get().then((value) =>
      {
        value.docs.forEach((doc) {
          if (doc.data()["annotation"] == null) {
            dataPoints.add(_MeasuredData(doc.data()["DateTime_stamp"].toDate(),
                doc.data()["measurement"], ""));
            print("No annotation");
          } else {
            dataPoints.add(_MeasuredData(doc.data()["DateTime_stamp"].toDate(),
                doc.data()["measurement"], doc.data()["annotation"]));
            print("Annotation: " + doc.data()["annotation"].toString());
          }
        })
      });
    } catch (e) {
      print("error catch");
      print(e);
      print("error!!!!");
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    } finally {
      setState(() {
        _initialized = true;
      });
      print ("initialised");
    }


    Stream collectionStream = reference.collection("time_series").snapshots();
    streamSubscription = collectionStream.listen((value) =>
    {
      dataPoints.add(_MeasuredData(value.docs.last.data()["DateTime_stamp"].toDate(),
          value.docs.last.data()["measurement"], value.docs.last.data()["annotation"]?? "")),
      print(value.docs.last.data()["DateTime_stamp"].toDate().toString() + ", " +
          value.docs.last.data()["measurement"].toString() + ", " + value.docs.last.data()["annotation"].toString()?? ""),
      _chartSeriesController.updateDataSource(
        addedDataIndexes: <int>[dataPoints.length - 1],
      )


    });
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
        dataPoints.add(_MeasuredData(timestamp, channel_1, ""));
        _chartSeriesController.updateDataSource(
          addedDataIndexes: <int>[dataPoints.length - 1],
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

              dataPoints[dataPoints.length -1].info = "Start",
        _chartSeriesController.updateDataSource(
        updatedDataIndexes: <int>[dataPoints.length -1],
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
      dataPoints[dataPoints.length -1].info = "End";
      _chartSeriesController.updateDataSource(
        updatedDataIndexes: <int>[dataPoints.length -1],
      );
      reference.collection("recordings").doc(reading_ID).collection("time_series").doc(dataPoints[dataPoints.length -1].time.toString()).update({
        'annotation': "End"});
      recording = false;
      setState(() {
        record_button = "Start Recording";
      });

    }

  }

  void scroll_to_end() {
    // zooming.zoomIn();
    zooming.zoomToSingleAxis(xAxis,0.99,10/dataPoints.length);
    zooming.panToDirection('right');
  }
  void _updateAnnotation(String input) {
    dataPoints[selected_index].info = input;
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
    print ("update data");
    if (left) {
      timer.cancel();
      return;
    }
    DateTime timestamp = DateTime.now();
    double generated = 30 + 10 * math.sin(timestamp.second * 24 * (math.pi / 180.0)) + 5*rng.nextDouble();
    setState(() {
      reading = generated;
    });
    dataPoints.add(_MeasuredData(timestamp, generated, ""));
    _chartSeriesController.updateDataSource(
      addedDataIndexes: <int>[dataPoints.length - 1],
    );
    print("Number of data points: " + dataPoints.length.toString());
    // if (dataPoints.length > 100) {
    //   dataPoints.removeAt(0);
    // }
    if (auto_scroll){
      scroll_to_end();
    }
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
