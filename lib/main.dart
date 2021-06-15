import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './PatientsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'Tools/constants.dart' as Constants;
import 'Tools/helper.dart';
import 'Tools/User.dart';
import './LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dcdg/dcdg.dart';

void main() => runApp(new MyApp());


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static User currentUser;
  StreamSubscription tokenStream;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      // Choice to keep log in status
      // await auth.FirebaseAuth.instance.setPersistence(auth.Persistence.NONE);
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print ("error catch");
      print (e);
      print ("error!!!!");
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }


    auth.FirebaseAuth FBA = auth.FirebaseAuth.instance;
    FBA.authStateChanges().listen((auth.User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! Updating user details with setState()');
        print(user.uid);
        print(user.email);
        print(User.fromFB(user).toString());

        setState(() {
          currentUser = User.fromFB(user);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {

// Show error message if initialization failed
    if (_error) {
      return MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 25,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Failed to initialise firebase!',
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                    ],
                  )),
            ),
          ));
    }
// Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (MyAppState.currentUser != null) {
      return MaterialApp(
          theme: ThemeData(accentColor: Color(Constants.COLOR_PRIMARY)),
          // debugShowCheckedModeBanner: false,
          color: Color(Constants.COLOR_PRIMARY),
          home: PatientsScreen(user: MyAppState.currentUser));

    } else {
      return MaterialApp(
          theme: ThemeData(accentColor: Color(Constants.COLOR_PRIMARY)),
          // debugShowCheckedModeBanner: false,
          color: Color(Constants.COLOR_PRIMARY),
          home: LoginScreen());
    }

  }
  @override
  void initState() {
    initializeFlutterFire();
    // WidgetsBinding.instance.addObserver(this);
    super.initState();

  }
}
