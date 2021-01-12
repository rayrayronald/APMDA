import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/database_helpers.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
//import 'package:firebase_database/firebase_database.dart';
//import 'dart:html' as html;
import 'package:firebase/firebase.dart' as fb;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/scheduler.dart';
import './Log_in.dart';


void main() {
  try {
    fb.initializeApp(
      apiKey: "AIzaSyCbLl2hVB4DCQeLPNzSh1iMZbMMj8i3IuM",
      authDomain: "apmda-499b8.firebaseapp.com",
      databaseURL: "https://apmda-499b8.firebaseio.com",
      storageBucket: "apmda-499b8.appspot.com",
    );
  } on fb.FirebaseJsNotLoadedException catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('Database'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PushData()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('Saving and Readaing data'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavePage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('Log in'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Log_in()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PushData extends StatefulWidget {
  @override
  _PushDataState createState() => _PushDataState();
}

class _PushDataState extends State<PushData> {
  int _RNG = 0;
  String _value = "";
  Map map = {};
  List<TimeSeriesSales> data = [];
  final fb.DatabaseReference ref = fb.database().ref('test_user');
  ScrollController _scrollController = new ScrollController();


//  @override                             // I use the SchedularBinding here
//  void initState() {
//    super.initState();
//    SchedulerBinding.instance.addPostFrameCallback((_) =>
//        _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
//  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
      ),
      body: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('Random generated number: $_RNG'),
              ElevatedButton(
                child: Text('Generate number & Save to DB'),
                onPressed: () {
                  _NumGen();
                  createData();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Read  DB'),
                    onPressed: () {
                      readData();
                    },
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(32.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text('Data on Database:\n\n$_value'),
                  )),
              Row(children: [
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: ElevatedButton(
                      child: Text('Gen Save Read x 5'),
                      onPressed: () {
                        for (int i = 0; i < 5; i ++) {
                          _NumGen();
                          createData();
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent,
//                              duration: const Duration(milliseconds: 100),
//                              curve: Curves.easeOut,
                            );
                          });
                        }
//                        readData();
//                        setState(() {
//                          _value = map.toString();
//                        });
                      },
                    )),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: ElevatedButton(
                    child: Text('Reset DB'),
                    onPressed: () {
                      deleteData();
                      readData();
                    },
                  ),
                )
              ]),
//              Padding(
//                padding: EdgeInsets.all(32.0),
//                child: SizedBox(
//                    height: MediaQuery.of(context).size.height * 0.1,
//                    width: MediaQuery.of(context).size.width * 0.8,
//                    child: SimpleTimeSeriesChart(
//                      getSeries(data),
//                      animate: false,
//                    )),
//              ),
            ]),
          ],
        ),
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,

              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * (data.length +1) /10,
                  child: SimpleTimeSeriesChart.withData(data)),
            ),
          )
      ]
      ),
    );
  }

  _NumGen() {
    var rng = new Random();
    setState(() {
      _RNG = rng.nextInt(100);
    });
  }

  void createData() async {
    var now = new DateTime.now();

    await ref
        .child("Channel_1")
        .child(now.year.toString() +
            "-" +
            now.month.toString().padLeft(2, "0") +
            "-" +
            now.day.toString().padLeft(2, "0") +
            " " +
            now.hour.toString().padLeft(2, "0") +
            ":" +
            now.minute.toString().padLeft(2, "0") +
            ":" +
            now.second.toString().padLeft(2, "0") +
            "," +
            now.millisecond.toString().padLeft(3, "0"))
        .set({'data': _RNG});
  }

  void readData() async {
    int size = data.length;
    int ita = 0;
    ref.child('Channel_1').once('value').then((dataSnapshot) {
      dataSnapshot.snapshot.forEach((childdataSnapshot) {
        if (ita >= size) {
          String sDT = childdataSnapshot.key;
          int val = childdataSnapshot.child('data').val();
          print(sDT);
          print(val);
          map.putIfAbsent(sDT, () => val);
          DateTime parseDT = DateTime.parse(sDT.replaceAll(',', '.'));
          print (parseDT.toString());
          data.add(new TimeSeriesSales(parseDT, val));
          print ("data size constant : " + size.toString() + ", actual data length: " + data.length.toString() + ", ita: " + ita.toString());
          print (data[0]);


        }
        ita++;
      });
      });
    setState(() {
      _value = map.toString();
    });
  }

  void deleteData() {
    ref.child('Channel_1').remove();
    map.clear();
    data.clear();
  }

}

class SavePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    _read();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    _save();
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read_DB'),
                  onPressed: () {
                    _read2DB();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save_DB'),
                  onPressed: () {
                    _save2DB();
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read_Local'),
                  onPressed: () {
                    _read2local();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save_Local'),
                  onPressed: () {
                    _save2local();
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                  context); // Navigate back to first route when tapped.
            },
            child: Text('Go back!'),
          ),
        ], // Column children
      ),
    );
  }

//   Replace these two methods in the examples that follow

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = 42;
    prefs.setInt(key, value);
    print('saved $value');
  }

  _read2DB() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
    Word word = await helper.queryWord(rowId);
    if (word == null) {
      print('read row $rowId: empty');
    } else {
      print('read row $rowId: ${word.word} ${word.frequency}');
    }
  }

  _save2DB() async {
    Word word = Word();
    word.word = 'hello';
    word.frequency = 15;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(word);
    print('inserted row: $id');
  }

  _read2local() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      String text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
  }

  _save2local() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.txt');
    final text = 'Hello World!';
    await file.writeAsString(text);
    print('saved');
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;


  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withData(List<TimeSeriesSales> data) {
    return new SimpleTimeSeriesChart(
      getSeries(data),
      // Disable animations for image tests.
      animate: false,
    );
  }

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {


    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      /// Customize the measure axis to have 2 ticks,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
          new charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
          viewport: new charts.NumericExtents(10.0, 90.0),
          tickFormatterSpec: new charts.BasicNumericTickFormatterSpec((num value) => '$value mV')
      ),

      domainAxis: DateTimeAxisSpecWorkaround(
        showAxisLine: true,
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'ss',
            transitionFormat: 'mm ss',
          ),
        ),
      ),
      behaviors: [new charts.PanAndZoomBehavior()],

    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> getSeries(
      List<TimeSeriesSales> data) {
    return [
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: data)
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class DateTimeAxisSpecWorkaround extends charts.DateTimeAxisSpec {

  const DateTimeAxisSpecWorkaround ({
    charts.RenderSpec<DateTime> renderSpec,
    charts.DateTimeTickProviderSpec tickProviderSpec,
    charts.DateTimeTickFormatterSpec tickFormatterSpec,
    bool showAxisLine,
  }) : super(
      renderSpec: renderSpec,
      tickProviderSpec: tickProviderSpec,
      tickFormatterSpec: tickFormatterSpec,
      showAxisLine: showAxisLine);

  @override
  configure(charts.Axis<DateTime> axis, charts.ChartContext context,
      charts.GraphicsFactory graphicsFactory) {
    super.configure(axis, context, graphicsFactory);
    axis.autoViewport = false;
  }
}

