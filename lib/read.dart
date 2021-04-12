// import 'package:firebase/src/interop/database_interop.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:firebase/firebase.dart' as fb;
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/scheduler.dart';
// import './Tools/constants.dart';
// import 'Tools/User.dart';
//
//
//
// class Read extends StatefulWidget {
//   final User user;
//
//   Read({@required this.user});
//
//   @override
//   _Read createState() => _Read(user);
// }
//
// class _Read extends State<Read> {
//   final User user;
//   _Read(this.user);
//
//   fb.DatabaseReference ref;
//   var now = new DateTime.now();
//   int _RNG = 50;
//   String _value = "";
//   Map map = {};
//   List<TimeSeriesMeasurement> data = [];
//
//   ScrollController _scrollController = new ScrollController();
//   bool scrollend = true;
//   bool running = false;
//   DateTime _time;
//   String _measures_old;
//   Map<String, num> _measures;
//   DateTime _sliderDomainValue = (new DateTime(2021,1,10,11,31));
//   String _sliderDragState = "";
//   Point<int> _sliderPosition = new Point(1, 1);
//
//   // Handles callbacks when the user drags the slider.
//   _onSliderChange(Point<int> point, dynamic domain, String roleId,charts.SliderListenerDragState dragState) {
//
//     // Request a build.
//     void rebuild(_) {
//       setState(() {
//         _sliderDomainValue = domain;
//         _sliderDragState = dragState.toString();
//         _sliderPosition = point;
//       });
//     }
//
//     SchedulerBinding.instance.addPostFrameCallback(rebuild);
//   }
//
//
//   _onSelectionChanged(charts.SelectionModel model) {
//     final selectedDatum = model.selectedDatum;
//     DateTime time;
//     final measures = <String, num>{};
//     if (selectedDatum.isNotEmpty) {
//       time = selectedDatum.first.datum.time;
//       selectedDatum.forEach((charts.SeriesDatum datumPair) {
//         measures[datumPair.series.displayName] = datumPair.datum.measurement;
//       });
//     }
//     setState(() {
//       _time = time;
//       _measures = measures;
//     });
//   }
//
//   @override
//   void initState() {
//     ref = fb.database().ref(DATAPATH + "/" + user.userID);
//     data.add(new TimeSeriesMeasurement(new DateTime.now().subtract(new Duration(seconds: 4)), 10));
//     data.add(new TimeSeriesMeasurement(new DateTime.now().subtract(new Duration(seconds: 3)), 20));
//     data.add(new TimeSeriesMeasurement(new DateTime.now().subtract(new Duration(seconds: 2)), 30));
//     data.add(new TimeSeriesMeasurement(new DateTime.now().subtract(new Duration(seconds: 1)), 40));
//     // data.add(new TimeSeriesMeasurement(new DateTime(2021,1,10,11,30), 10));
//     // data.add(new TimeSeriesMeasurement(new DateTime(2021,1,10,11,31), 11));
//     // data.add(new TimeSeriesMeasurement(new DateTime(2021,1,10,11,33), 12));
//     // data.add(new TimeSeriesMeasurement(new DateTime(2021,1,10,11,37), 13));
//     super.initState();
//   }
//
//
//   static List<charts.Series<TimeSeriesMeasurement, DateTime>> channel_to_data(
//       List<TimeSeriesMeasurement> data, String channel) {
//     return [
//       new charts.Series<TimeSeriesMeasurement, DateTime>(
//           id: channel,
//           colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//           domainFn: (TimeSeriesMeasurement datum, _) => datum.time,
//           measureFn: (TimeSeriesMeasurement datum, _) => datum.measurement,
//           data: data)
//     ];
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     readData();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Database'),
//       ),
//       body: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   Text('Time started: $now'),
//                   Padding(
//                       padding: EdgeInsets.all(32.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.2,
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         child: Text('Data on Database:\n\n$_value'),
//                       )),
//                   Row(children: [
//                     Padding(
//                         padding: EdgeInsets.all(6.0),
//                         child: ElevatedButton(
//                           child: Text('Start'),
//                           onPressed: () {
//                             running = true;
//                             start();
//                           },
//                         )),
//                     Padding(
//                         padding: EdgeInsets.all(6.0),
//                         child: ElevatedButton(
//                           child: Text('Stop'),
//                           onPressed: () {
//                             running = false;
//                           },
//                         )),
//                     Padding(
//                       padding: EdgeInsets.all(6.0),
//                       child: ElevatedButton(
//                         child: Text('Reset'),
//                         onPressed: () {
//                           deleteData();
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(6.0),
//                       child: ElevatedButton(
//                         child: Text('Toggle Scroll'),
//                         onPressed: () {
//                           if (scrollend) {
//                             scrollend = false;
//                           } else {
//                             scrollend = true;
//                           }
//                         },
//                       ),
//                     )
//                   ]),
//                 ]),
//               ],
//             ),
//             SafeArea(
//               child: NotificationListener<ScrollNotification>(
//                 child: SingleChildScrollView(
//                 controller: _scrollController,
//                 scrollDirection: Axis.horizontal,
//
//                 child: SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     width: MediaQuery.of(context).size.width * (data.length ) /20,
//                     child: charts.TimeSeriesChart (
//                         // [charts.Series<TimeSeriesMeasurement, DateTime>(
//                         //   id: 'Sales',
//                         //   domainFn: (TimeSeriesMeasurement sales, _) => sales.time,
//                         //   measureFn: (TimeSeriesMeasurement sales, _) => sales.measurement,
//                         //   data: [
//                         //     new TimeSeriesMeasurement(new DateTime(2021,1,10), 5),
//                         //     new TimeSeriesMeasurement(new DateTime(2021,1,11), 25),
//                         //     new TimeSeriesMeasurement(new DateTime(2021,1,12), 100),
//                         //     new TimeSeriesMeasurement(new DateTime(2021,1,13), 75),
//                         //   ],
//                         // )],
//                       channel_to_data(data, "channel_1"),
//
//
//                       animate: false,
//                       behaviors: [
//                         new charts.Slider(
//                             initialDomainValue: data.first.time,
//                             onChangeCallback: _onSliderChange,
//                         ),
//                       ],
//                         selectionModels: [
//                           new charts.SelectionModelConfig(
//                             type: charts.SelectionModelType.info,
//                             changedListener: _onSelectionChanged,
//                           )
//                         ],
//                     )
//
//
//                     // child: charts.TimeSeriesChart(
//                     //   getSeries(data),
//                     //   selectionModels: [
//                     //     new charts.SelectionModelConfig(
//                     //       type: charts.SelectionModelType.info,
//                     //       changedListener: _onSelectionChanged,
//                     //     )
//                     //   ],
//                     //   animate: false,
//                     //   // dateTimeFactory: const charts.LocalDateTimeFactory(),
//                     //   primaryMeasureAxis: new charts.NumericAxisSpec(
//                     //       tickProviderSpec: new charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
//                     //       viewport: new charts.NumericExtents(10.0, 90.0),
//                     //       tickFormatterSpec: new charts.BasicNumericTickFormatterSpec((num value) => '$value mV')
//                     //   ),
//                     //
//                     //   // domainAxis: new charts.DateTimeAxisSpec(
//                     //   //   tickProviderSpec: charts.DayTickProviderSpec(increments: [10]),
//                     //   //   tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
//                     //   //     day: new charts.TimeFormatterSpec(
//                     //   //         format: 'EEE', transitionFormat: 'EEE', noonFormat: 'EEE'),
//                     //   //   ),
//                     //   //   showAxisLine: false,
//                     //   // ),
//                     //
//                     //
//                     //
//                     //   // domainAxis: DateTimeAxisSpecWorkaround(
//                     //   //   showAxisLine: true,
//                     //   //   tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
//                     //   //     day: charts.TimeFormatterSpec(
//                     //   //       format: 'ss',
//                     //   //       transitionFormat: 'mm ss',
//                     //   //     ),
//                     //   //   ),
//                     //   // ),
//                     //
//                     //   behaviors: [new charts.PanAndZoomBehavior(),
//                     //     new charts.Slider(
//                     //         initialDomainValue: new DateTime(2021,1,10,11,33), onChangeCallback: _onSliderChange),
//                     //   ],
//                     // )
//
//
//
//
//
//                 ),
//               ),
//                 onNotification: (ScrollNotification scrollInfo) {
//                   print(scrollInfo.metrics.pixels);
//                   return false;
//                 },
//               )
//             ),
//             Text('Selected:\n\n$_time\n\n$_measures'),
//             Text('Slider domain value: ${_sliderDomainValue}'),
//             Text(
//                 'Slider position: ${_sliderPosition.x}, ${_sliderPosition.y}'),
//             Text('Slider drag state: ${_sliderDragState}')
//           ]
//       ),
//     );
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//   Future<void> start() async {
//     var rng;
//     while (running) {
//       rng = new Random();
//       setState(() {
//         _RNG += rng.nextInt(6)-3;
//       });
//       await Future.delayed(Duration(milliseconds: 100));
//       data.add(new TimeSeriesMeasurement(new DateTime.now(), _RNG));
//
//       if (scrollend) {
//         SchedulerBinding.instance.addPostFrameCallback((_) {
//           _scrollController.jumpTo(
//             _scrollController.position.maxScrollExtent
//             // duration: const Duration(milliseconds: 50),
//             // curve: Curves.easeOut,
//           );
//         });
//       }
//     }
//   }
//
//
//
//
//   _NumGen() {
//     var rng = new Random();
//     setState(() {
//       _RNG = rng.nextInt(100);
//     });
//   }
//
//   void createData() async {
//     var now = new DateTime.now();
//
//     await ref
//         .child("Channel_1")
//         .child(now.year.toString() +
//         "-" +
//         now.month.toString().padLeft(2, "0") +
//         "-" +
//         now.day.toString().padLeft(2, "0") +
//         " " +
//         now.hour.toString().padLeft(2, "0") +
//         ":" +
//         now.minute.toString().padLeft(2, "0") +
//         ":" +
//         now.second.toString().padLeft(2, "0") +
//         "," +
//         now.millisecond.toString().padLeft(3, "0"))
//         .set({'data': _RNG});
//   }
//
//   void readData() async {
//     int size = data.length;
//     int ita = 0;
//     ref.child('Channel_1').once('value').then((dataSnapshot) {
//       dataSnapshot.snapshot.forEach((childdataSnapshot) {
//         if (ita >= size) {
//           String sDT = childdataSnapshot.key;
//           int val = childdataSnapshot.child('data').val();
//           print(sDT);
//           print(val);
//           map.putIfAbsent(sDT, () => val);
//           DateTime parseDT = DateTime.parse(sDT.replaceAll(',', '.'));
//           print (parseDT.toString());
//           data.add(new TimeSeriesMeasurement(parseDT, val));
//           print ("data size constant : " + size.toString() + ", actual data length: " + data.length.toString() + ", ita: " + ita.toString());
//           print (data[0]);
//
//
//         }
//         ita++;
//       });
//     });
//     setState(() {
//       _value = map.toString();
//     });
//   }
//
//   void deleteData() {
//     ref.child('Channel_1').remove();
//     map.clear();
//     data.clear();
//   }
//
// }
//
//
// class SimpleTimeSeriesChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;
//   /// Creates a [TimeSeriesChart] with sample data and no transition.
//   factory SimpleTimeSeriesChart.withData(List<TimeSeriesSales> data) {
//     return new SimpleTimeSeriesChart(
//       getSeries(data),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }
//
//   SimpleTimeSeriesChart(this.seriesList, {this.animate});
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return new charts.TimeSeriesChart(
//       seriesList,
//
//
//       selectionModels: [
//         new charts.SelectionModelConfig(
//           type: charts.SelectionModelType.info,
//         )
//       ],
//       animate: animate,
//       // Optionally pass in a [DateTimeFactory] used by the chart. The factory
//       // should create the same type of [DateTime] as the data provided. If none
//       // specified, the default creates local date time.
//       dateTimeFactory: const charts.LocalDateTimeFactory(),
//       /// Customize the measure axis to have 2 ticks,
//       primaryMeasureAxis: new charts.NumericAxisSpec(
//           tickProviderSpec:
//           new charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
//           viewport: new charts.NumericExtents(10.0, 90.0),
//           tickFormatterSpec: new charts.BasicNumericTickFormatterSpec((num value) => '$value mV')
//       ),
//
//       domainAxis: DateTimeAxisSpecWorkaround(
//         showAxisLine: true,
//         tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
//           day: charts.TimeFormatterSpec(
//             format: 'ss',
//             transitionFormat: 'mm ss',
//           ),
//         ),
//       ),
//       behaviors: [new charts.PanAndZoomBehavior()],
//
//
//
//     );
//   }
//
//
//   static List<charts.Series<TimeSeriesSales, DateTime>> getSeries(
//       List<TimeSeriesSales> data) {
//     return [
//       new charts.Series<TimeSeriesSales, DateTime>(
//           id: 'Sales',
//           colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//           domainFn: (TimeSeriesSales sales, _) => sales.time,
//           measureFn: (TimeSeriesSales sales, _) => sales.sales,
//           data: data)
//     ];
//   }
// }
//
// /// Sample time series data type.
// class TimeSeriesSales {
//   final DateTime time;
//   final int sales;
//
//   TimeSeriesSales(this.time, this.sales);
// }
//
// /// Sample linear data type.
// class TimeSeriesMeasurement {
//   final DateTime time;
//   final int measurement;
//
//   TimeSeriesMeasurement(this.time, this.measurement);
// }
//
// class TimeSecondsMeasurement {
//   final int time;
//   final int measure;
//
//   TimeSecondsMeasurement(this.time, this.measure);
// }
//
// class DateTimeAxisSpecWorkaround extends charts.DateTimeAxisSpec {
//
//   const DateTimeAxisSpecWorkaround ({
//     charts.RenderSpec<DateTime> renderSpec,
//     charts.DateTimeTickProviderSpec tickProviderSpec,
//     charts.DateTimeTickFormatterSpec tickFormatterSpec,
//     bool showAxisLine,
//   }) : super(
//       renderSpec: renderSpec,
//       tickProviderSpec: tickProviderSpec,
//       tickFormatterSpec: tickFormatterSpec,
//       showAxisLine: showAxisLine);
//
//   @override
//   configure(charts.Axis<DateTime> axis, charts.ChartContext context,
//       charts.GraphicsFactory graphicsFactory) {
//     super.configure(axis, context, graphicsFactory);
//     axis.autoViewport = false;
//   }
// }
//
