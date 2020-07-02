import 'package:flutter/material.dart';
import 'package:mjtrn02/models/usermodel.dart';
import 'package:mjtrn02/pages/mainshop.dart';
import 'package:mjtrn02/pages/mainuser.dart';
import 'package:mjtrn02/pages/register.dart';
import 'package:mjtrn02/utility/myapi.dart';
import 'package:mjtrn02/utility/mystyle.dart';
import 'package:mjtrn02/utility/normaldialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

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
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            print('login ');
            normalDialog(context, 'กรุณากรอก ทุกช่อง');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    UserModel model = await MyApi().getUserWhereUser(user);
    if (model == null) {
      normalDialog(context, 'ไม่มี $user ในฐานข้อมูล');
    } else {
      if (password == model.password) {
        switch (model.type) {
          case 'User':
            routTo(Mainuser());
            break;
          case 'Shop':
            routTo(Mainshop());
            break;
          default:
        }
      } else {
        normalDialog(context, 'Password Fail');
      }
    }
  }

  void routTo(Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
          onChanged: (value) => user = value.trim(),
          decoration: MyStyle().myInputDecoration('User :'),
        ),
      );

  Widget passwordForm() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          decoration: MyStyle().myInputDecoration('Password :'),
        ),
      );
}
