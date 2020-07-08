import 'package:flutter/material.dart';
import 'package:mjtrn02/utility/mystyle.dart';

class Mainuser extends StatefulWidget {
  @override
  _MainuserState createState() => _MainuserState();
}

class _MainuserState extends State<Mainuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MyStyle().menuSignOut(context),
      ),
      appBar: AppBar(
        title: Text('MainUser'),
      ),
    );
  }
}
