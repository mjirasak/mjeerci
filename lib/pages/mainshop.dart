import 'package:flutter/material.dart';
import 'package:mjtrn02/utility/mystyle.dart';
import 'package:mjtrn02/widget/showInfomation.dart';
import 'package:mjtrn02/widget/showmyordershop.dart';
import 'package:mjtrn02/widget/showmyproduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainshop extends StatefulWidget {
  @override
  _MainshopState createState() => _MainshopState();
}

class _MainshopState extends State<Mainshop> {
  Widget currentwidget = ShowMyOrderShop();

  String idShop, nameShop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findShop();
  }

  Future<Null> findShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idShop = preferences.getString('id');
      nameShop = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text(nameShop == null ? 'Wellcom Shop ' : 'ข้าม $nameShop'),
      ),
      body: currentwidget,
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              UserAccountsDrawerHeader(accountName: null, accountEmail: null),
              menuMyOrder(),
              menuMyProduct(),
              menuMyInfomation(),
            ],
          ),
          MyStyle().menuSignOut(context),
        ],
      ),
    );
  }

  ListTile menuMyOrder() => ListTile(
        leading: Icon(Icons.looks_one),
        title: Text('Show My Order'),
        subtitle: Text('ดูรายการ Order'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentwidget = ShowMyOrderShop();
          });
        },
      );

  ListTile menuMyProduct() => ListTile(
        leading: Icon(Icons.looks_two),
        title: Text('Show My Product'),
        subtitle: Text('ดูรายการสินค้า'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentwidget = ShowMyProduct();
          });
        },
      );

  ListTile menuMyInfomation() => ListTile(
        leading: Icon(Icons.looks_3),
        title: Text('Show My Info'),
        subtitle: Text('ดูรายละเอียดสินค้า'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            print('id aaaaaa  $idShop');
            currentwidget = ShowInfomation(
              idShop: idShop,
            );
          });
        },
      );
}
