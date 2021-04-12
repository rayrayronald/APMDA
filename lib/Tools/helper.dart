import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
// import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'constants.dart';



// Initialise Firebase
FBI() async{
  await Firebase.initializeApp();

  // final databaseReference = FirebaseDatabase.instance.reference();


  // try {
  //   fb.initializeApp(
  //     apiKey: "AIzaSyCbLl2hVB4DCQeLPNzSh1iMZbMMj8i3IuM",
  //     authDomain: "apmda-499b8.firebaseapp.com",
  //     databaseURL: "https://apmda-499b8.firebaseio.com",
  //     storageBucket: "apmda-499b8.appspot.com",
  //   );
  // } on fb.FirebaseJsNotLoadedException catch (e) {
  //   print(e);
  // } catch (e) {
  //   print(e);
  // }
}



class Patient_Item {
  String name;
  String ID;
  Patient_Item({this.name,this.ID});

  factory Patient_Item.fromJson(Map<dynamic,dynamic> parsedJson) {
    return Patient_Item(name:parsedJson['Name'],ID: parsedJson['ID']);
  }
}

class Patient_List{
  List<Patient_Item> patientlist;
  Patient_List({this.patientlist});


  factory Patient_List.fromJSON(Map<dynamic,dynamic> json){
    return Patient_List(
        patientlist: parsepatients(json)
    );
  }

  static List<Patient_Item> parsepatients(patientJSON){
    var rList=patientJSON['patients_DB'] as List;
    List<Patient_Item> patientList=rList.map((data) => Patient_Item.fromJson(data)).toList();  //Add this
    return patientList;

  }
}

class MakeCall{
  List<Patient_Item> listItems=[];

  //     ref = fb.database().ref(DATAPATH + "/" + user.userID);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference pateints = FirebaseFirestore.instance.collection('pateints_DB');

  //
  //
  //
  // Future<List<Patient_Item>> firebaseCalls (DatabaseReference databaseReference) async{
  //   Patient_List patientList;
  //   DataSnapshot dataSnapshot = await databaseReference.once();
  //   Map<dynamic,dynamic> jsonResponse=dataSnapshot.value[0]['content'];
  //   patientList = new Patient_List.fromJSON(jsonResponse);
  //   listItems.addAll(patientList.patientList);
  //
  //   return listItems;
  // }
}


//helper method to show progress
ProgressDialog progressDialog;

showProgress(BuildContext context, String message, bool isDismissible) async {
  progressDialog = new ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: isDismissible);
  progressDialog.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: Color(COLOR_PRIMARY),
      progressWidget: Container(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));
  await progressDialog.show();
}

updateProgress(String message) {
  progressDialog.update(message: message);
}

hideProgress() async {
  await progressDialog.hide();
}

//helper method to show alert dialog
showAlertDialog(BuildContext context, String title, String content) {
  // set up the AlertDialog
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  showDialog
    (
    context: context,builder: (

      BuildContext context
      ) {
    return alert;
  },
  );
}


// show the dialog


pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => destination));
}

push(BuildContext context, Widget destination) {
  Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => destination));
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
          (Route<dynamic> route) => predict);
}
