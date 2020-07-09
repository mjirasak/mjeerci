import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mjtrn02/utility/myconstant.dart';
import 'package:mjtrn02/utility/mystyle.dart';
import 'package:mjtrn02/utility/normaldialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductShop extends StatefulWidget {
  @override
  _AddProductShopState createState() => _AddProductShopState();
}

class _AddProductShopState extends State<AddProductShop> {
  File file;
  String pathImage, name, price, detail, nameShop, idShop, code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findShop();
  }

  Future<Null> findShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idShop = preferences.getString('id');
    nameShop = preferences.getString('Name');
    print('idShop = $idShop, nameShop = $nameShop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'กรุุณาใส่ภาพ');
          } else if (name == null ||
              name.isEmpty ||
              price == null ||
              price.isEmpty ||
              price == null ||
              price.isEmpty ||
              detail == null ||
              detail.isEmpty) {
            normalDialog(context, 'โปรดใส่ข้อมุลให้ครบ');
          } else {
            uploadAndInsertProduct();
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              imagesGroup(),
              nameForm(),
              priceForm(),
              detailForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: MyStyle().myInputDecoration('Name Product :'),
        ),
      );

  Widget priceForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => price = value.trim(),
          decoration: MyStyle().myInputDecoration('Price Product :'),
        ),
      );

  Widget detailForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => detail = value.trim(),
          decoration: MyStyle().myInputDecoration('Detail Product :'),
        ),
      );

  Future<Null> chooseSource(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget imagesGroup() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseSource(ImageSource.camera),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: 200.0,
            height: 200.0,
            child:
                file == null ? Image.asset('images/pic.png') : Image.file(file),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseSource(ImageSource.gallery),
          ),
        ],
      );

  Future<Null> uploadAndInsertProduct() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'idShop${idShop}product$i.jpg';
    print('nameFile = $nameFile');
    code = 'idShop${idShop}code$i';
    print('Code = $code');

    try {
      String urlUpload = '${MyConstant().domain}/RCI/saveFileUng.php';

      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);

      FormData formData = FormData.fromMap(map);
      await Dio().post(urlUpload, data: formData).then((value) async {
        pathImage = '/RCI/Product/$nameFile';
        print('upload Succes => pathImage = ${MyConstant().domain}$pathImage ');
        String urlInsert =
            'https://6ca748081031.ngrok.io/RCI/addProductUng.php?isAdd=true&NameShop=$nameShop&Name=$name&Detail=$detail&Price=$price&Detail=$detail&PathImage=$pathImage&Code=$code&IdShop=$idShop';
        await Dio().get(urlInsert).then((value) {
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            normalDialog(context, 'Try again');
          }
        });
      });
    } catch (e) {}
  }
}
