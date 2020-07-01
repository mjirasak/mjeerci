import 'package:flutter/material.dart';
import 'package:mjtrn02/pages/register.dart';
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showLogo(),
              MyStyle().showTexth1('Show App name'),
              userForm(),
              passwordForm(),
              SizedBox(
                height: 8.0,
              ),
              loginButton(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Container loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        onPressed: () {},
        child: Text('Login'),
      ),
    );
  }

  Container registerButton() {
    return Container(
      width: 250.0,
      child: FlatButton(
        onPressed: () {
          print('Register...');
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Register(),
          );
          Navigator.push(context, route);
        },
        child: Text(
          'New Register',
          style: TextStyle(
            color: Colors.pink.shade600,
          ),
        ),
      ),
    );
  }

  Widget userForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250.0,
        child: TextField(
          decoration: MyStyle().myInputDecoration('User :'),
        ),
      );

  Widget passwordForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250.0,
        child: TextField(
          decoration: MyStyle().myInputDecoration('Password :'),
        ),
      );
}
