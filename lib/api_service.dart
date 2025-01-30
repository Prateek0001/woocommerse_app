import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woocommerse_app/config.dart';
import 'package:woocommerse_app/models/customer.dart';

class ApiService {
  Future<bool> createCustomer (CustomerModel? model) async {
    bool ret = false;
    try{
      var response = await Dio().post(Config.url + Config.customerURL,
      data: model?.toJson(),
      options:  Options(headers: {
        HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
        HttpHeaders.contentTypeHeader : "application/json"
      }));

      if (response.statusCode == 201){
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404){
        ret = false;
      } else {
        ret = false;
      }
    }

    return ret;
  }
}