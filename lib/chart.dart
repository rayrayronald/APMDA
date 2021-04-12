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



class data extends StatefulWidget {
  final User user;
  final String patient;
  final DocumentReference reference;

  data({@required this.user, @required this.patient, @required this.reference});

  @override
  State createState() {
    return _data(user, patient, reference);
  }
}

class _data extends State<data> {
  final User user;
  final String patient;
  final DocumentReference reference;

  _data(this.user, this.patient, this.reference);

  DateTime selected_DT;
  double seleted_measurement;
  int selected_index;
  String selected_annotation = "";

  var rng = new math.Random();
  Timer timer;
  bool recording = false;
  double reading = 0;
  String record_button = "Start Recording";
  String reading_ID;
  String annotation_S = "Description";
  bool left = false;

  ZoomPanBehavior zooming = ZoomPanBehavior(
    enableSelectionZooming: false,
    enableDoubleTapZooming: false,
    enablePinching: true,
    enablePanning: true,
    enableMouseWheelZooming: true,
    zoomMode: ZoomMode.x,
    // maximumZoomLevel: 0.4
  );
  TrackballBehavior trackball = TrackballBehavior(enable: true);
  TooltipBehavior tooltip = TooltipBehavior(enable: true);
  SelectionBehavior selection = SelectionBehavior(
      enable: true,
      selectedColor: Colors.red,
      selectedBorderWidth: 1,
      unselectedColor: Colors.grey,
      unselectedBorderWidth: 1);
  DateTimeAxis xAxis = DateTimeAxis(
    // dateFormat: DateFormat.y(),
      rangePadding: ChartRangePadding.additional,
      intervalType: DateTimeIntervalType.seconds,
      interval: 1
    // visibleMaximum: data[3].year
  );
  ChartSeriesController _chartSeriesController;
  List<_MeasuredData> data = [];


  @override void initState() {
    Timer.periodic(
        const Duration(milliseconds: 1000), _updateData);
    super.initState();
  }

  @override
  void dispose() {
    left = true;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    // Show a loader until FlutterFire is initialized
    if (data.length<2) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SingleChildScrollView(
            child: Column(children: [
              //Initialize the chart widget
              SfCartesianChart(
                  title: ChartTitle(text: "Patient  ID " + patient),
                  primaryYAxis: NumericAxis(
                    minimum: 20,
                    maximum: 50,
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
                  // Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(3.0),
                  //       //Initialize the spark charts widget
                  //       child: ElevatedButton(
                  //         child: Text('+'),
                  //         onPressed: () {
                  //           // zooming.reset();
                  //           // zooming.zoomMode.index.
                  //           zooming.zoomIn();
                  //         },
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(3.0),
                  //       //Initialize the spark charts widget
                  //       child: ElevatedButton(
                  //         child: Text('-'),
                  //         onPressed: () {
                  //           // zooming.reset();
                  //           zooming.zoomOut();
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
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
                        _updateAnnotation("O");
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
                        hintText: 'Type your annotation...',
                      ),
                    )
                ),
              ),
            ])
        );

  }






  void _newRecording() {
    if (!recording) {
      DateTime start_time = new DateTime.now();
      reading_ID = start_time.toString();
      reference.collection("recordings").doc(start_time.toString()).set({
        'DateTime_start': start_time, // John Doe
        'sensor': "mV_sensor", // Stokes and Sons
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
