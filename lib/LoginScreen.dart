
import 'package:flutter/material.dart';
import 'Adobe/Log_in.dart';
import './patients.dart';
import './Time_series_chart.dart';
import './Testing.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'Tools/constants.dart' as Constants;
import 'Tools/helper.dart';
import 'Tools/User.dart';
import './main.dart';




class LoginScreen extends StatefulWidget {
  @override
  State createState() {
    return _LoginScreen();
  }
}


class _LoginScreen extends State<LoginScreen> {
  User currentUser;
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String email = Constants.EMAIL, password = Constants.PASSWORD;
  MediaQueryData mediaData;

  @override

  void initState() {
    super.initState();

    //mediaData = MediaQuery.of(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in page'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200 + MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(Constants.COLOR_BACKGROUND),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(Constants.COLOR_SHADOW),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(Constants.COLOR_PRIMARY),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(Constants.COLOR_BACKGROUND),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NHS patient monitoring app',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, right: 24.0, left: 24.0),
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                              //initialValue: 'apmda@nhs.co.uk',
                              onChanged: (String val) {
                                email = val;
                              },
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              style: TextStyle(fontSize: 18.0),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Color(Constants.COLOR_PRIMARY),
                              decoration: InputDecoration(
                                  contentPadding:
                                  new EdgeInsets.only(left: 16, right: 16),
                                  fillColor: Colors.white,
                                  hintText: 'E-mail Address',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Color(Constants.COLOR_PRIMARY),
                                          width: 2.0)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ))),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, right: 24.0, left: 24.0),
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              //initialValue: 'apmdaNHS',

                              onChanged: (String val) {
                                password = val;
                              },
                              onFieldSubmitted: (password) async {
                                // await login();
                              },
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(fontSize: 18.0),
                              cursorColor: Color(Constants.COLOR_PRIMARY),
                              decoration: InputDecoration(
                                  contentPadding:
                                  new EdgeInsets.only(left: 16, right: 16),
                                  fillColor: Colors.white,
                                  hintText: 'Password',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Color(Constants.COLOR_PRIMARY),
                                          width: 2.0)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: 40.0, right: 40),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: double.infinity),
                          child: RaisedButton(
                            color: Color(Constants.COLOR_PRIMARY),
                            child: Text(
                              'Log In',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.white,
                            splashColor: Color(Constants.COLOR_PRIMARY),
                            onPressed: () async {
                              await login();
                            },
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side:
                                BorderSide(color: Color(Constants.COLOR_PRIMARY))),
                          ),
                        ),
                      ),
                  ]

                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //     child: Text('Database'),
              //     onPressed: () {
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => PushData()),
              //       // );
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //     child: Text('Saving and Reading data'),
              //     onPressed: () {
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => _MyHomePage()),
              //       // );
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //     child: Text('UI/UX app demo'),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Log_in()),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),

    );
  }



  login() async {

    showProgress(context, 'Logging in, please wait...', false);
    User user = await loginWithUserNameAndPassword();
    // print(user.toString());

    if (user != null) {
      hideProgress();
      pushAndRemoveUntil(context, patients(user: user), false);
    }
  }

  Future<User> loginWithUserNameAndPassword() async {

    try {
      auth.UserCredential userCredential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User user;
      // print(userCredential.user.toString());
      user = User.fromFB(userCredential.user);
      hideProgress();
      MyAppState.currentUser = user;
      return user;


      // auth.FirebaseAuth FBA = auth.FirebaseAuth.instance;
      // FBA.authStateChanges().listen((auth.User user) {
      //   if (user == null) {
      //     print('User is currently signed out!');
      //   } else {
      //     print('User is signed in! Updating user details with setState()');
      //     setState(() {
      //       currentUser = user;
      //     });
      //     print(user.uid);
      //     // print(user.toString());
      //   }
      // });
      // return userCredential.user;

    } on auth.FirebaseAuthException catch (exception) {
      hideProgress();
      print('Failed with error code: ${exception.code}');
      print(exception.message);
      switch ((exception).code) {
        case "invalid-email":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'Wrong Email format');
          break;
        case "wrong-password":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'Wrong password');
          break;
        case "user-not-found":
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'No user corresponds to this email');
          break;
        case "user-disabled":
          showAlertDialog(
              context, 'Couldn\'t Authenticate', 'This user is disabled');
          break;
        case 'too-many-requests':
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'Too many requests, Please try again later.');
          break;
      }
      print(exception.toString());
      return null;
    } catch (e) {
      hideProgress();
      showAlertDialog(
          context, 'Couldn\'t Authenticate', 'Login failed. Please try again.');
      print(e.toString());
      return null;
    }
  }

}

