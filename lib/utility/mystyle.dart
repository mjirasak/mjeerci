import 'package:flutter/material.dart';

class MyStyle {
  Color mainColor = Colors.pink;
  Color darkColor = Colors.blue.shade300;

  Text showTexth1(String string) => Text(
        string,
        style: TextStyle(
          color: darkColor,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico',
        ),
      );

  Container showLogo() {
    return Container(
      width: 150.0,
      child: Image.asset('images/logo.png'),
    );
  }

  MyStyle();
}
