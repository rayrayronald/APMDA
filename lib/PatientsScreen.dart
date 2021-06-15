import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/UI/MyDrawer.dart';
import 'package:my_app/flutter_bluetooth_serial_view.dart';
import 'Tools/User.dart';
import 'Tools/helper.dart';
import 'UI/MyAppBar.dart';
import 'UI/MyDrawer.dart';
import './ChartScreen.dart';
import './flutter_blue.dart';
import './HistoryScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Tools/stub_js.dart' if (dart.library.js) 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;



class PatientsScreen extends StatefulWidget {
  final User user;

  PatientsScreen({@required this.user});

  @override
  State createState() {
    return _PatientsScreen(user);
  }
}

class _PatientsScreen extends State<PatientsScreen> {
  final User user;

  _PatientsScreen(this.user);
  // Initializing a global key for SnackBar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String sensor = "";


  @override
  void initState() {
    FirebaseFirestore.instance.collection('patients_DB').doc(
        'aqKkUWATzxDeRXgpSJN9').update({'sensor_connected': false});
    super.initState();
    print(getFromJS("value"));
    print(getFromJS("value"));
  }

  String button_string (bool connected) {
    if (connected) {
      return "Live Data";
    } else {
      return "Connect";
    }
  }



  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('patients_DB');



    return Material(
      child: Scaffold (
        appBar: MyAppBar(title: Text('Connected Patients'), user: user),
        drawer: MyDrawer(user: user),
        body: StreamBuilder(
          stream: users.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return new ListView(
              children: snapshot.data.docs.map((document) {
                print (document.id.toString());
                return new ListTile(
                  subtitle: new Text(document['name']),
                  title: new Text("Patient ID    " + document.id),
                  trailing: Column(
                    children: <Widget> [
                      Container(
                        // margin: const EdgeInsets.only(right: 14.0),
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 1.0),
                              child: ElevatedButton(
                                  child: Text(button_string(document['sensor_connected'])),
                                  onLongPress: (){
                                    users.doc(document.id).update({'sensor_connected': false});
                                    },
                                  onPressed: (){
                                    if (!document['sensor_connected']) {
                                      return (
                                          showDialog(
                                              context: context,
                                              builder: (ctx) =>
                                                  AlertDialog(
                                                    title: Text("Select Data source"),
                                                    content: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                    TextButton(
                                                    child: Text("Simulated - SPO2 sensor"),
                                                    onPressed: () {
                                                      users.doc(document.id).update({'sensor_connected': true});
                                                      users.doc(document.id).update({'sensor_chosen': 'SPO2'});
                                                      show(context, "Long press to disconnect.");
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                          TextButton(
                                              child: Text("Simulated - Blood glucose sensor"),
                                              onPressed: () {
                                                users.doc(document.id).update({'sensor_connected': true});
                                                users.doc(document.id).update({'sensor_chosen': 'Blood glucose'});
                                                show(context, "Long press to disconnect.");
                                                Navigator.pop(context);
                                              },
                                            ),
                                                          TextButton(
                                                            child: Text("Chrome Web Serial API"),
                                                            onPressed: kIsWeb ? () {
                                                              Navigator.pop(context);
                                                              // users.doc(document.id).update({'sensor_connected': true});
                                                              // users.doc(document.id).update({'sensor_chosen': 'EZ Link'});
                                                              try {
                                                                js.context.callMethod('chrome_serial');
                                                              } catch (e) {
                                                                show(context, e);
                                                              } finally {
                                                                if (getFromJS("connected")){
                                                                  users.doc(document.id).update({'sensor_connected': true});
                                                                  users.doc(document.id).update({'sensor_chosen': 'Chrome Web Serial API'});
                                                                  push(context, ChartScreen(user: user, patient: document.id, reference: users.doc(document.id), sensor: "Chrome Web Serial API", document_name: "NONE", connection: null));
                                                                }
                                                              }
                                                            } : () {
                                                              Navigator.pop(context);
                                                              show(context, "Only supported on Chrome with developer features enabled.");
                                                              },
                                                          ),
                                                          TextButton(
                                                            child: Text("Chrome Web Bluetooth API"),
                                                            onPressed: kIsWeb ? () {
                                                              show(context, "Data parsing not yet supported.");
                                                              Navigator.pop(context);
                                                              js.context.callMethod('chrome_ble');
                                                            } : () {
                                                              Navigator.pop(context);
                                                              show(context, "Only supported on Chrome with developer features enabled.");
                                                              },
                                                          ),
                                                          TextButton(
                                                            child: Text("flutter_bluetooth_serial"),
                                                            onPressed: kIsWeb ? () {
                                                              show(context, "Not supported in web app mode.\nOnly simulated data available.");
                                                              Navigator.pop(context);
                                                              // push(context, flutter_bluetooth_serial_view(user: user, patient: document.id, reference: users.doc(document.id)));
                                                            } : () {
                                                              Navigator.pop(context);
                                                              // users.doc(document.id).update({'sensor_connected': true});
                                                              // users.doc(document.id).update({'sensor_chosen': 'EZ Link'});
                                                              push(context, flutter_bluetooth_serial_view(user: user, patient: document.id, reference: users.doc(document.id)));
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text("flutter_blue"),
                                                            onPressed: kIsWeb ? () {
                                                              show(context, "Not supported in web app mode.");
                                                              Navigator.pop(context);
                                                            } : () {
                                                              Navigator.pop(context);
                                                              push(context, flutter_blue(user: user));
                                                              show(context, "Data parsing not yet supported.");

                                                            },
                                                          ),
                                                    ]
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Cancel"),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      )
                                                    ],
                                                  ))
                                      );
                                    } else {
                                      print(user.userID);
                                      // push(context, Read(user: user));
                                      push(context, ChartScreen(user: user, patient: document.id, reference: users.doc(document.id), sensor: document["sensor_chosen"], document_name: "NONE", connection: null));

                                      // push(context, data(user: user, patient: document.id, reference: users.doc(document.id), sensor: document["sensor_chosen"]));
                                    }
                                  },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (document['sensor_connected']) {
                                        return Colors.green;
                                      } else
                                      return Colors.orangeAccent;
                                    },
                                  ),
                                ),//

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 1.0),
                              child: ElevatedButton(
                                  child: Text('History'),
                                  onPressed: (){
                                    print(user.userID);
                                    // push(context, Read(user: user));
                                    push(context, HistoryScreen(user: user, patient: document.id, reference: users.doc(document.id)));
                                  }//
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),

                );
              }).toList(),
            );
          },
        )
      )
    );


  }
}