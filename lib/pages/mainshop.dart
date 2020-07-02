import 'package:flutter/material.dart';

class Mainshop extends StatefulWidget {
  @override
  _MainshopState createState() => _MainshopState();
}

class _MainshopState extends State<Mainshop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('Wellcom Shop'),
      ),
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(accountName: null, accountEmail: null),
          menuMyOrder(),
          menuMyProduct(),
          menuMyInfomation(),
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
        },
      );

  ListTile menuMyProduct() => ListTile(
        leading: Icon(Icons.looks_two),
        title: Text('Show My Product'),
        subtitle: Text('ดูรายการสินค้า'),
        onTap: () {
          Navigator.pop(context);
        },
      );

  ListTile menuMyInfomation() => ListTile(
        leading: Icon(Icons.looks_3),
        title: Text('Show My Info'),
        subtitle: Text('ดูรายละเอียดสินค้า'),
        onTap: () {
          Navigator.pop(context);
        },
      );
}
