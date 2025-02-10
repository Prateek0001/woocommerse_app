import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dunn_oil/models/login_model.dart';

class SharedService {

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("login_details") != null ? true : false;
  }

  static Future <LoginResponseModel?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final loginDetails = prefs.getString("login_details");
    return loginDetails != null 
        ? LoginResponseModel.fromJson(jsonDecode(loginDetails))
        : null;

  }

  static Future<void> setLoginDetails(LoginResponseModel? loginResponse) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("login_details", jsonEncode(loginResponse?.toJson()));

  }

  static Future<void> logout() async {
    await setLoginDetails(null);
  }
}