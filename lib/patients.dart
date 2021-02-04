import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/MyDrawer.dart';
import './User.dart';
import './MyAppBar.dart';
import './MyDrawer.dart';



class patients extends StatefulWidget {
  final User user;

  patients({Key key, @required this.user}) : super(key: key);

  @override
  State createState() {
    return _patients(user);
  }
}

class _patients extends State<patients> {
  final User user;

  _patients(this.user);

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Scaffold (
        appBar: MyAppBar(title: Text('Connected Patients'), user: user),
        drawer: MyDrawer(),

      )
    );




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