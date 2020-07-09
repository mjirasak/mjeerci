import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mjtrn02/models/usermodel.dart';
import 'package:mjtrn02/utility/myconstant.dart';

import 'normaldialog.dart';

class MyApi {
  Future<Null> editValueOnMySQL(
    BuildContext context,
    String id,
    String dateTimeString,
    String phone,
    String gender,
    String educateString,
  ) async {
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

  Future<UserModel> getUserWhereUser(String user) async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereUserUng.php?User=$user&isAdd=true';
    Response response = await Dio().get(url);
    print('Res = $response');
    if (response.toString() == 'null') {
      return null;
    } else {
      var result = json.decode(response.data);

      for (var map in result) {
        UserModel model = UserModel.fromJson(map);
        return model;
      }
    }
  }

  MyApi();
}
