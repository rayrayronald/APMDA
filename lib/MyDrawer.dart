import 'package:flutter/material.dart';
import 'dart:math';
import './constants.dart' as Constants;

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import './helper.dart';
import './main.dart';
import './LoginScreen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text(
                      'Menu',
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
