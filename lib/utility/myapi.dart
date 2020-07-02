import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mjtrn02/models/usermodel.dart';
import 'package:mjtrn02/utility/myconstant.dart';

class MyApi {
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
