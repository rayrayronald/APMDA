import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/UI/MyDrawer.dart';
import 'package:my_app/bundler/javascript_bundler.dart';
import 'package:my_app/serial.dart';
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



  @override
  void initState() {
    FirebaseFirestore.instance.collection('patients_DB').doc('aqKkUWATzxDeRXgpSJN9').update({'sensor_connected': false});
    super.initState();
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
                                  onPressed: (){
                                    if (!document['sensor_connected']) {
                                      return (
                                          showDialog(
                                              context: context,
                                              builder: (ctx) =>
                                                  AlertDialog(
                                                    title: Text("Select sensor"),
                                                    content: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                    TextButton(
                                                    child: Text("SPO2 sensor"),
                                                    onPressed: () {
                                                      users.doc(document.id).update({'sensor_connected': true});
                                                      users.doc(document.id).update({'sensor_chosen': 'SPO2'});

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                          TextButton(
                                              child: Text("Blood glucose sensor"),
                                              onPressed: () {
                                                users.doc(document.id).update({'sensor_connected': true});
                                                users.doc(document.id).update({'sensor_chosen': 'Blood glucose'});
                                                Navigator.pop(context);
                                              },
                                            ),
                                                          TextButton(
                                                            child: Text("Chrome blue"),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              js.context.callMethod('confirm', ['Hello from Dart!']);
                                                              // showConfirm("second");

                                                              js.context.callMethod('chrome_ble');
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text("Chrome serial"),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              js.context.callMethod('chrome_serial');
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text("Flutter Blue"),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              push(context, ble(user: user));

                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text("FRB"),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              push(context, flutter_react_ble(user: user));
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text("Serial"),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              users.doc(document.id).update({'sensor_connected': true});
                                                              users.doc(document.id).update({'sensor_chosen': 'EZ Link'});
                                                              push(context, serial(user: user, patient: document.id, reference: users.doc(document.id), sensor: document["sensor_chosen"]));
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