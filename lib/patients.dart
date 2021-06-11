import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/UI/MyDrawer.dart';
import 'package:my_app/bundler/javascript_bundler.dart';
import 'package:my_app/flutter_bluetooth_serial_view.dart';
import 'Tools/User.dart';
import 'Tools/helper.dart';
import 'UI/MyAppBar.dart';
import 'UI/MyDrawer.dart';
import './read.dart';
import './Testing.dart';
import './data.dart';
import './ble.dart';
import './flutter_reactive_ble.dart';
import './history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:html'; // web only
// import 'dart:js' as js;
// import 'package:my_app/bundler/stub_bundler.dart' if (dart.library.js) 'package:my_app/bundler/javascript_bundler.dart';
import 'package:my_app/bundler/stub_js.dart' if (dart.library.js) 'dart:js' as js;
// import 'package:js/js.dart';
import 'package:my_app/serial_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



class patients extends StatefulWidget {
  final User user;

  patients({@required this.user});

  @override
  State createState() {
    return _patients(user);
  }
}

class _patients extends State<patients> {
  final User user;

  _patients(this.user);
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
                                                                  push(context, serial_data(user: user, patient: document.id, reference: users.doc(document.id), sensor: "Chrome Web Serial API", connection: null));
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
                                                              show(context, "Not supported in web app mode.");
                                                              Navigator.pop(context);
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
                                                              push(context, ble(user: user));
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
                                      push(context, data(user: user, patient: document.id, reference: users.doc(document.id), sensor: document["sensor_chosen"]));
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
                                    push(context, history(user: user, patient: document.id, reference: users.doc(document.id)));
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


    // return new FutureBuilder(
    //
    //   future: users.get(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (!snapshot.hasData) return new Text('Loading...');
    //     return new ListView(
    //       children: snapshot.data.docs.map((document) {
    //         print (document.id.toString());
    //         return new ListTile(
    //           title: new Text(document['name']),
    //           // subtitle: new Text(document['type']),
    //         );
    //       }).toList(),
    //     );
    //   },
    // );

    // return Material(
    //   child: Scaffold (
    //     appBar: MyAppBar(title: Text('Connected Patients'), user: user),
    //     drawer: MyDrawer(),
    //     body: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(20.0),
    //           child: ElevatedButton(
    //               child: Text('Patient name'),
    //               onPressed: (){
    //                 print(user.userID);
    //                 // push(context, Read(user: user));
    //                 push(context, data(user: user, patient: "195781",));
    //               }//
    //           ),
    //         ),
    //
    //       ],
    //     )
    //
    //   )
    // );




    // return Scaffold(
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Text(
      //           'Menu',
      //           style: TextStyle(color: Colors.white),
      //         ),
      //         decoration: BoxDecoration(
      //           color: Color(COLOR_PRIMARY),
      //         ),
      //       ),
      //       ListTile(
      //         title: Text(
      //           'Logout',
      //           style: TextStyle(color: Colors.black),
      //         ),
      //         leading: Transform.rotate(
      //             angle: pi/1,
      //             child: Icon(Icons.exit_to_app, color: Colors.black)),
      //         onTap: () async {
      //           // user.active = false;
      //           // user.lastOnlineTimestamp = Timestamp.now();
      //           await auth.FirebaseAuth.instance.signOut();
      //           MyAppState.currentUser = null;
      //           pushAndRemoveUntil(context, LoginScreen(), false);
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      // appBar: AppBar(
      //   title: Text(
      //     'Connected Patients',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      // ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.max,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       // displayCircleImage(user.profilePictureURL, 125, false),
      //       // Padding(
      //       //   padding: const EdgeInsets.all(8.0),
      //       //   child: Text(user.firstName),
      //       // ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text(user.email),
      //       ),
      //
      //       // Padding(
      //       //   padding: const EdgeInsets.all(8.0),
      //       //   child: Text(user.userID),
      //       // ),
      //     ],
      //   ),
      // ),
    // );
  }
}