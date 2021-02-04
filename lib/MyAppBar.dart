import 'package:flutter/material.dart';
import './User.dart';
import './constants.dart' as Constants;
import 'package:flutter/cupertino.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  MyAppBar({this.title, @required this.user});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;
  final User user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title,
        backgroundColor: Color(Constants.COLOR_PRIMARY),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 15),
              child: Text(user.email)
          )
        ]
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
