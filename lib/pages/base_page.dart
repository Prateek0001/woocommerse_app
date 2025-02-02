import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/config.dart';
import 'package:woocommerse_app/provider/cart_provider.dart';
import 'package:woocommerse_app/provider/loader_provider.dart';
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
    return Consumer<LoaderProvider>(
      builder: (context, loaderModel, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: ProgressHUD(
            inAsyncCall: loaderModel.isApiCallProcess,
            opacity: 0.3,
            child: pageUI() ?? SizedBox(),
          ),
        );
      },
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
        Provider.of<CartProvider>(context, listen: false).cartItems.isEmpty
            ? Container()
            : Positioned(
                child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.green[800],
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Center(
                        child: Text(Provider.of<CartProvider>(context, listen: false).cartItems.toString(),style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                    )
                  ],
                ),
              ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
