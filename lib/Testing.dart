import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:math' as math;
import 'Tools/User.dart';

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  // _MyHomePage({Key key}) : super(key: key);
  final User user;

  MyHomePage({@required this.user});

  @override
  State createState() {
    return _MyHomePageState(user);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final User user;

  _MyHomePageState(this.user);

  // _MyHomePageState() {
  //   // timer = Timer.periodic(const Duration(milliseconds: 1000), _updateData);
  // }
  ZoomPanBehavior zooming;
  TrackballBehavior trackball;
  TooltipBehavior tooltip;
  SelectionBehavior selection;
  List <CartesianChartAnnotation> annotation;
  DateTimeAxis xAxis;

  DateTime selected_DT;
  double seleted_sales;
  int selected_index;
  int delay = 0;
  Timer timer;
  bool running = false;
  ChartSeriesController _chartSeriesController;
  List<_SalesData> data = [
    _SalesData(new DateTime.now().subtract(new Duration(seconds: 10)), 35,"start"),
    _SalesData(new DateTime.now().subtract(new Duration(seconds: 8)), 28,""),
    _SalesData(new DateTime.now().subtract(new Duration(seconds: 6)), 34,""),
    _SalesData(new DateTime.now().subtract(new Duration(seconds: 4)), 32,""),
    _SalesData(new DateTime.now().subtract(new Duration(seconds: 2)), 40,"")
  ];

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
    annotation = [CartesianChartAnnotation(
        widget:
        Container(
            child: const Text('^')
        ),
        coordinateUnit: CoordinateUnit.point,
        x: data[1].year,
        y: data[1].sales
    )];
    xAxis = DateTimeAxis(
      // dateFormat: DateFormat.y(),
        rangePadding: ChartRangePadding.additional,
        intervalType: DateTimeIntervalType.seconds,
        interval: 1
      // visibleMaximum: data[3].year
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sensor Reading'),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(38.0),
            //Initialize the spark charts widget
            child: ElevatedButton(
              child: Text('Start recording'),
              onPressed: () {
                if (running) {
                  setState(() {
                    timer = null;
                    running = false;
                  });
                } else {
                  setState(() {
                    Timer.periodic(
                        const Duration(milliseconds: 1000), _updateData);
                    running = true;
                  });
                }
                data.add(_SalesData(
                    new DateTime.now(),
                    20 +
                        20 *
                            math.sin(DateTime.now().second *
                                1000 *
                                (math.pi / 180.0)),""));
                _chartSeriesController.updateDataSource(
                  addedDataIndexes: <int>[data.length - 1],
                );
                // tooltip.showByPixel(50.0,50.0);
              },
            ),
          ),

          //Initialize the chart widget
          SfCartesianChart(
              // Chart title
              title: ChartTitle(text: 'Real time reading'),
              primaryYAxis: NumericAxis(
                // numberFormat: NumberFormat.simpleCurrency(),
                minimum: 10,
                maximum: 40,
              ),
              primaryXAxis: xAxis,
              // Enable legend
              legend: Legend(isVisible: false),
              trackballBehavior: trackball,
              zoomPanBehavior: zooming,
              tooltipBehavior: tooltip,
              selectionType: SelectionType.point,
              annotations: annotation,


              onZooming: (ZoomPanArgs args) {
                print("Zoom Position: " + args.currentZoomPosition
                    .toString()); // Storing the zoomPosition and the zoomFactor
                print("Zoom Factor: " + args
                    .currentZoomFactor.toString()); // Storing the zoomPosition and the zoomFactor
                print("meow");
              },
              onSelectionChanged: (SelectionArgs args) {
                print(args.pointIndex);
                setState(() {
                  selected_DT = data[args.pointIndex].year;
                  seleted_sales = data[args.pointIndex].sales;
                  selected_index = args.pointIndex;
                });
              },
              onTrackballPositionChanging: (TrackballArgs args) {
                // print(args.chartPointInfo.chartDataPoint);
              },
              onActualRangeChanged: (ActualRangeChangedArgs args) {
                if (args.axisName == 'primaryXAxis') {
                  // print (args.visibleMin);
                  // print (args.visibleMax);
                  // print (args.actualInterval);
                  if (delay > 3) {
                    // trackball.showByIndex(args.);
                  }
                }
              },
              series: <ChartSeries<_SalesData, DateTime>>[
                LineSeries<_SalesData, DateTime>(
                  enableTooltip: false,
                  selectionBehavior: selection,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  // Map the data label text for each point from the data source
                  dataLabelMapper: (_SalesData sales, _) => sales.info,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true
                  ),
                  name: 'Sales',
                  // Enable data label
                  // dataLabelSettings: DataLabelSettings(isVisible: true)
                )
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text('View whole graph'),
                  onPressed: () {
                    zooming.reset();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: ElevatedButton(
                  child: Text('Scroll to now'),
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
                      child: Text('+'),
                      onPressed: () {
                        // zooming.reset();
                        // zooming.zoomMode.index.
                        zooming.zoomIn();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    //Initialize the spark charts widget
                    child: ElevatedButton(
                      child: Text('-'),
                      onPressed: () {
                        // zooming.reset();
                        zooming.zoomOut();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Text("Selected Time: "),
              Text(selected_DT.toString()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            //Initialize the spark charts widget
            child: ElevatedButton(
              child: Text('Annotate'),
              onPressed: () {
                // print (annotation.length);
                // annotation.add(CartesianChartAnnotation(
                //   widget:
                //   Container(
                //       child: const Text('O')
                //   ),
                //   coordinateUnit: CoordinateUnit.point,
                //   x: selected_DT,
                //   y: seleted_sales,
                // ));
                // print ( "annotate");
                // print (annotation.length);
                data[selected_index].info = "O";
                _chartSeriesController.updateDataSource(
                  updatedDataIndexes: <int>[selected_index],
                );
              },
            ),
          ),
        ]));
  }

  void _updateData(Timer timer) {
    delay++;
    data.add(_SalesData(new DateTime.now(),
        30 + 10 * math.sin(DateTime.now().second * 24 * (math.pi / 180.0)), ""));
    _chartSeriesController.updateDataSource(
      addedDataIndexes: <int>[data.length - 1],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales, this.info);

  final DateTime year;
  final double sales;
  String info;
}
