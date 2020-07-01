import 'package:flutter/material.dart';
import 'package:mjtrn02/utility/mystyle.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyStyle().showLogo(),
            MyStyle().showTexth1('Show App name'),
            userForm(),
          ],
        ),
      ),
    );
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(),
      );
}
