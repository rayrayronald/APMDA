import 'package:flutter/material.dart';
import 'dart:math';
import '../Tools/constants.dart' as Constants;

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import '../Tools/helper.dart';
import '../main.dart';
import '../LoginScreen.dart';
import '../Tools/User.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({@required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text(
                      user.email,
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Color(Constants.COLOR_PRIMARY),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: Transform.rotate(
                        angle: pi / 1,
                        child: Icon(Icons.exit_to_app, color: Colors.black)),
                    onTap: () async {
                      // user.active = false;
                      // user.lastOnlineTimestamp = Timestamp.now();
                      await auth.FirebaseAuth.instance.signOut();
                      MyAppState.currentUser = null;
                      pushAndRemoveUntil(context, LoginScreen(), false);
                    },
                  ),
                ],
              ),
            );
  }
}
