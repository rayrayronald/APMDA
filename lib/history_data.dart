import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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



class history_data extends StatefulWidget {
  final User user;
  final String patient;
  final DocumentReference reference;
  final String name;
  final String sensor;


  history_data({@required this.user, @required this.patient, @required this.reference, @required this.name, @required this.sensor});

  @override
  State createState() {
    return _history_data(user, patient, reference, name, sensor);
  }
}

class _history_data extends State<history_data> with WidgetsBindingObserver {
  final User user;
  final String patient;
  final DocumentReference reference;
  final String name;
  final String sensor;

  _history_data(this.user, this.patient, this.reference, this.name, this.sensor);

  DateTime selected_DT;
  double seleted_measurement;
  int selected_index;
  String selected_annotation = "";


  var rng = new math.Random();
  int delay = 0;
  Timer timer;
  bool running = false;
  String reading = "N/A";
  String annotation_S = "Description";
  double y_up = 50;
  double y_down = 20;


  ZoomPanBehavior zooming;
  TrackballBehavior trackball;
  TooltipBehavior tooltip;
  SelectionBehavior selection;
  DateTimeAxis xAxis;
  MarkerSettings markerSettings;
  ChartSeriesController _chartSeriesController;
  List<_MeasuredData> data = [];
  StreamSubscription<double> streamSubscription;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;


  @override
  void initState() {
    loadData();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamSubscription.cancel();
    super.dispose();
  }

  void loadData() async {
    try {
      await reference.collection("time_series").get().then((value) =>
      {
        value.docs.forEach((doc) {
          if (doc.data()["annotation"] == null) {
            data.add(_MeasuredData(doc.data()["DateTime_stamp"].toDate(),
                doc.data()["measurement"], ""));
            print("null");
          } else {
            data.add(_MeasuredData(doc.data()["DateTime_stamp"].toDate(),
                doc.data()["measurement"], doc.data()["annotation"]));
            print("else");
          }
        })
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print("error catch");
      print(e);
      print("error!!!!");
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
    Stream collectionStream = reference.collection("time_series").snapshots();
    streamSubscription = collectionStream.listen((value) =>
    {
    if (value.docs.last.dataPoints()["annotation"] == null) {
        data.add(_MeasuredData(value.docs.last.dataPoints()["DateTime_stamp"].toDate(),
    value.docs.last.dataPoints()["measurement"], "")),
    print("null")
    } else {
    data.add(_MeasuredData(value.docs.last.dataPoints()["DateTime_stamp"].toDate(),
    value.docs.last.dataPoints()["measurement"], value.docs.last.dataPoints()["annotation"])),
    print("else")
    },
    _chartSeriesController.updateDataSource(
    addedDataIndexes: <int>[data.length - 1],
    )

      //GetChanges()

      // if (value != null) {
      //     print("Current data: " + value.toString())
      // } else {
      // print("Current data: null")
      // }
      // print(value.docs.last.data()["DateTime_stamp"].toString())
      // value.GetChanges.docs.forEach((doc) {
      //   if (doc.data()["annotation"] == null) {
      //     data.add(_MeasuredData(doc.data()["DateTime_stamp"].toDate(),
      //         doc.data()["measurement"], ""));
      //     print("null");
      //   } else {
      //     data.add(_MeasuredData(doc.data()["DateTime_stamp"].toDate(),
      //         doc.data()["measurement"], doc.data()["annotation"]));
      //     print("else");
      //   }
      //   _chartSeriesController.updateDataSource(
      //     addedDataIndexes: <int>[data.length - 1],
      //   );
      // })
    });
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
    }
// Show a loader until data is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(sensor + " Recording history"),
        ),
        body: SingleChildScrollView (
            child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text('Delete recording'),
                  onPressed: () {
                    return (
                        showDialog(
                            context: context,
                            builder: (ctx) =>
                                AlertDialog(
                                  title: Text("Confirm deleting history " +
                                      name.toString()),
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
                ),
              ),
            ],
          ),
          //Initialize the chart widget
          SfCartesianChart(
              title: ChartTitle(text: "Patient ID:  " + patient +"\nStarted:  "+ name),
              primaryYAxis: NumericAxis(
                labelFormat: '{value}%',
                minimum: y_down,
                maximum: y_up,
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
                  yValueMapper: (_MeasuredData datapoint, _) =>
                  datapoint.measurement,
                  // Map the data label text for each point from the data source
                  dataLabelMapper: (_MeasuredData datapoint, _) =>
                  datapoint.info,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
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
                    zooming.zoomToSingleAxis(xAxis, 0.99, 10 / data.length);
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

  void _updateAnnotation(String input) {
    data[selected_index].info = input;
    _chartSeriesController.updateDataSource(
      updatedDataIndexes: <int>[selected_index],
    );
    setState(() {
      selected_annotation = input;
    });
    reference.collection("time_series").doc(selected_DT.toString()).update({
      'annotation': input});
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