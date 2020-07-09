import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mjtrn02/models/usermodel.dart';
import 'package:mjtrn02/utility/myapi.dart';
import 'package:mjtrn02/utility/myconstant.dart';
import 'package:mjtrn02/utility/mystyle.dart';
import 'package:mjtrn02/utility/normaldialog.dart';

class EditInfoShop extends StatefulWidget {
  final UserModel userModel;

  EditInfoShop({Key key, this.userModel}) : super(key: key);

  @override
  _EditInfoShopState createState() => _EditInfoShopState();
}

class _EditInfoShopState extends State<EditInfoShop> {
  UserModel userModel;
  String dateTimeString, gender, educateString, address, phone, id;
  List<String> eductions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
    gender = userModel.gendel;
    educateString = userModel.education;
    address = userModel.address;
    phone = userModel.phone;
    id = userModel.id;
    findCurrentTime();
    eductions = MyConstant().educates;
  }

  Future<Null> findCurrentTime() async {
    DateTime dateTime = DateTime.now();
    setState(() {
      dateTimeString = DateFormat('dd-MM-yyyy').format(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              'Date = $dateTimeString, address = $address, phone = $phone, gender = $gender,edutcion = $educateString');
          if (address.isEmpty || phone.isEmpty) {
            normalDialog(context, 'Please Fill evety blank');
          } else {
            MyApi().editValueOnMySQL(
                context, id, dateTimeString, phone, gender, educateString);
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(
        title: Text('Edit Information'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            showDate(),
            addressForm(),
            phoneForm(),
            genderGroup(),
            educationDropdown(),
          ],
        ),
      ),
    );
  }

  Container educationDropdown() => Container(
        width: 250.0,
        child: DropdownButton<String>(
          value: educateString,
          items: eductions
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              educateString = value;
            });
          },
        ),
      );

  Container genderGroup() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            mailRadio(),
            femailRadio(),
          ],
        ),
      );

  Row mailRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'Male',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
        Text('ชาย'),
      ],
    );
  }

  Row femailRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'female',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
        Text('หญิง'),
      ],
    );
  }

  Widget addressForm() => Container(
        width: 250.0,
        margin: EdgeInsets.only(top: 16.0),
        child: TextFormField(
          onChanged: (value) => address = value.trim(),
          initialValue: address,
          decoration: MyStyle().myInputDecoration('Address'),
        ),
      );

  Widget phoneForm() => Container(
        width: 250.0,
        margin: EdgeInsets.only(top: 16.0),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          onChanged: (value) => phone = value.trim(),
          initialValue: phone,
          decoration: MyStyle().myInputDecoration('Phone'),
        ),
      );

  Widget showDate() {
    return MyStyle().showTexth2(
      'DateTime = $dateTimeString',
    );
  }
}
