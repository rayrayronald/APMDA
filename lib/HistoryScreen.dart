import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/UI/MyDrawer.dart';
import 'Tools/User.dart';
import 'Tools/helper.dart';
import 'UI/MyAppBar.dart';
import 'UI/MyDrawer.dart';
import './ChartScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class HistoryScreen extends StatefulWidget {
  final User user;
  final String patient;
  final DocumentReference reference;


  HistoryScreen({@required this.user, @required this.patient, @required this.reference});

  @override
  State createState() {
    return _HistoryScreen(user, patient, reference);
  }
}

class _HistoryScreen extends State<HistoryScreen> {
  final User user;
  final String patient;
  final DocumentReference reference;


  _HistoryScreen(this.user, this.patient, this.reference);

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Scaffold (
        appBar: AppBar(
          title: Text(patient + "\nPatient History",
          textAlign: TextAlign.center,)),
        // drawer: MyDrawer(),
        body: StreamBuilder(
          stream: reference.collection("recordings").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return new ListView(
              children: snapshot.data.docs.map((document) {
                return new ListTile(
                  title: new Text(document.id),
                  subtitle: new Text("Type:    " + document['sensor']),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                        child: Icon(Icons.keyboard_arrow_right),
                        onPressed: (){
                          print(user.userID);
                          // push(context, Read(user: user));
                          push(context, ChartScreen(user: user, patient: patient, reference: reference.collection("recordings").doc(document.id), sensor: document['sensor'], document_name: document.id, connection: null ));
                        }//
                    ),
                  ),
                  // onLongPress: push(context, history_data(user: user, patient: patient, reference: reference.collection("recordings").doc(document['DateTime_start'].toDate().toString()))),
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