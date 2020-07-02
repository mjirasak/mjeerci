import 'package:flutter/material.dart';

class ShowInfomation extends StatefulWidget {
  final String idShop;
  ShowInfomation({Key key, this.idShop});
  @override
  _ShowInfomationState createState() => _ShowInfomationState();
}

class _ShowInfomationState extends State<ShowInfomation> {
  String idShop;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   setState(() {

      idShop = widget.idShop;
      print('id BBBBB $idShop');
   });
  }

  @override
  Widget build(BuildContext context) {
    return Text('This is Infomation id = $idShop');
  }
}
