import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mjtrn02/utility/myconstant.dart';
import 'package:mjtrn02/utility/mystyle.dart';
import 'package:mjtrn02/utility/normaldialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  String dateTimeString, gender, educateString, address, phone, id;
  List<String> educates = [
    'ต่ำกว่า ป.6',
    'มัธยมต้น',
    'มัธยมปลาย',
    'ปริญาตรี',
    'ปริญาโท',
    'ปริญาเอก'
  ];

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findCurrentTime();
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
          if (address == null ||
              address.isEmpty ||
              phone == null ||
              phone.isEmpty) {
            normalDialog(context, 'กรุณากรอก ที่อยู่ และ เบอร์โทรศัพท์ ด่วน');
          } else if (gender == null) {
            normalDialog(context, 'กรุณาเลือก Gender ด้วย');
          } else if (educateString == null) {
            normalDialog(context, 'โปรดเลือกการศึกษา');
          } else {
            editValueOnMySQL();
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            titleDate(),
            showDate(),
            addressForm(),
            phoneForm(),
            genterGroup(),
            educateGroup(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('เพิ่มข้อมูล ร้านค้า'),
      ),
    );
  }

  Container educateGroup() => Container(
        child: DropdownButton<String>(
          value: educateString,
          items: educates
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          hint: Text('โปรดเลือกระดับการศึกษา'),
          onChanged: (value) {
            setState(() {
              educateString = value;
            });
          },
        ),
      );

  Container genterGroup() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            maleRadio(),
            femaleRadio(),
          ],
        ),
      );

  Row maleRadio() {
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

  Row femaleRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'Female',
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

  Row showDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyStyle().showTexth1(dateTimeString == null ? '' : dateTimeString),
      ],
    );
  }

  Widget titleDate() => MyStyle().showTexth2('วันเวลาที่บันทึก');

  Widget addressForm() => Container(
        margin: EdgeInsets.only(top: 16.0),
        width: 250.0,
        child: TextField(
          onChanged: (value) => address = value.trim(),
          decoration: MyStyle().myInputDecoration('ที่อยู่'),
        ),
      );

  Widget phoneForm() => Container(
        margin: EdgeInsets.only(top: 16.0),
        width: 250.0,
        child: TextField(
          onChanged: (value) => phone = value.trim(),
          keyboardType: TextInputType.phone,
          decoration: MyStyle().myInputDecoration('เบอร์โทรศัพท์'),
        ),
      );

  Future<Null> editValueOnMySQL() async {
    String url =
        '${MyConstant().domain}/RCI/editUserWhereIdUng.php?isAdd=true&CreateDate=$dateTimeString&Address=$educateString&Phone=$phone&Gendel=$gender&Education=$educateString&id=$id';

    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        print('id = $id ');
        Navigator.pop(context);
      } else {
        normalDialog(context, 'โปรดกรุณาพยายามอีกครั้ง');
      }
    });
  }
}
