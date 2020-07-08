import 'package:flutter/material.dart';
import 'package:mjtrn02/pages/authen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStyle {
  Color mainColor = Colors.pink;
  Color darkColor = Colors.blue.shade300;

  Widget menuSignOut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.red.shade800),
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Sign Out',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.blue.shade600,
              ),
            ),
            subtitle: Text('ออกจาก Account'),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();

              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Authen(),
              );
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
          ),
        ),
      ],
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  InputDecoration myInputDecoration(String string) {
    return InputDecoration(
      labelText: string,
      border: OutlineInputBorder(),
    );
  }

  Text showTexth1(String string) => Text(
        string,
        style: TextStyle(
          color: darkColor,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico',
        ),
      );

  Widget showTexth2(String string) => Container(
        margin: EdgeInsets.only(left: 8),
        child: Text(
          string,
          style: TextStyle(
            color: darkColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
          ),
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
