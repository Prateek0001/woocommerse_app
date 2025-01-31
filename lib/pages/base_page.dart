import 'package:flutter/material.dart';
import 'package:woocommerse_app/config.dart';
import 'package:woocommerse_app/utils/ProgressHUD.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: pageUI() ?? SizedBox(),
      ),
    );
  }

  Widget? pageUI() {
    return null;
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: true,
      title: Text(
        Config.appName,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
