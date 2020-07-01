import 'package:flutter/material.dart';

class TitleBar {
  static AppBar instance(BuildContext context) {
    return AppBar(
      title: Text("Clicker Game"),
      automaticallyImplyLeading: false,
      actions: <Widget> [
        FlatButton(
          child: Text("HOME"),
          onPressed: () => {Navigator.pushNamed(context, "/")}
        ),
        FlatButton(
          child: Text("SHOP"),
          onPressed: () => {Navigator.pushNamed(context, "/shop")},
        ),          
      ],
    );
  }
//  @override
//  Widget build(BuildContext context) {
//    return 
 // }
}
