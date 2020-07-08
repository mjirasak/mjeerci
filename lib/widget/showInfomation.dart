import 'package:flutter/material.dart';
import 'package:mjtrn02/pages/addinfoshop.dart';

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
      body: Column(
        children: <Widget>[
          Text('This is Infomation id = $idShop'),
        ],
      ),
    );
  }
}
