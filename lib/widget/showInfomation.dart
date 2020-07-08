import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mjtrn02/models/usermodel.dart';
import 'package:mjtrn02/pages/addinfoshop.dart';
import 'package:mjtrn02/utility/myconstant.dart';
import 'package:mjtrn02/utility/mystyle.dart';

class ShowInfomation extends StatefulWidget {
  final String idShop;
  ShowInfomation({Key key, this.idShop});
  @override
  _ShowInfomationState createState() => _ShowInfomationState();
}

class _ShowInfomationState extends State<ShowInfomation> {
  String idShop;
  bool status = true;
  bool status2 = true;
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      idShop = widget.idShop;
      print('id BBBBB $idShop');
    });
  }

  Future<Null> readInfo() async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereIdUng.php?isAdd=true&id=$idShop';
    Response response = await Dio().get(url);
    setState(() {
      status2 = false;
    });
    var result = json.decode(response.data);
    for (var map in result) {
      userModel = UserModel.fromJson(map);

      String dateTime = userModel.createDate;
      if (!(dateTime == null || dateTime.isEmpty)) {
        setState(() {
          status = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => AddInfoShop(),
          );
          Navigator.push(context, route).then((value) => null);
        },
        child: Icon(Icons.add),
      ),
      body: status2
          ? MyStyle().showProgress()
          : status
              ? Center(
                  child: MyStyle().showTexth1('ยังไม่มีข้้อมูล'),
                )
              : showContent(),
    );
  }

  Widget showContent() => Column(
        children: <Widget>[
          MyStyle().showTexth1('ข้อมูลร้าน ${userModel.name}'),
          MyStyle().showTexth2('บันทึกวันที่ ${userModel.createDate}'),
          showAddress(),
          showGendel(),
          showEducate(),
          showPhone(),
        ],
      );

  ListTile showAddress() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 36,
        color: Colors.purple,
      ),
      title: MyStyle().showTexth2(userModel.address),
    );
  }

  ListTile showGendel() {
    return ListTile(
      leading: Icon(
        Icons.account_box,
        size: 36,
        color: Colors.purple,
      ),
      title: MyStyle().showTexth2(userModel.gendel),
    );
  }

  ListTile showEducate() {
    return ListTile(
      leading: Icon(
        Icons.label_important,
        size: 36,
        color: Colors.purple,
      ),
      title: MyStyle().showTexth2(userModel.education),
    );
  }

    ListTile showPhone() {
    return ListTile(
      leading: Icon(
        Icons.label_important,
        size: 36,
        color: Colors.purple,
      ),
      title: MyStyle().showTexth2(userModel.phone),
    );
  }

}
