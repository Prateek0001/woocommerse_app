import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dunn_oil/config.dart';
import 'package:dunn_oil/provider/cart_provider.dart';
import 'package:dunn_oil/provider/loader_provider.dart';
import 'package:dunn_oil/utils/ProgressHUD.dart';

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
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: true,
      title: Text(
        Config.appName,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        // Icon(
        //   Icons.notifications_none,
        //   color: Colors.white,
        // ),
        // SizedBox(
        //   width: 10,
        // ),
        // Icon(
        //   Icons.shopping_cart,
        //   color: Colors.white,
        // ),
        // Consumer<CartProvider>(
        //   builder: (context, cartProvider, child) {
        //     return cartProvider.cartItems.isEmpty
        //         ? Container()
        //         : Positioned(
        //             top: 0,
        //             right: 0,
        //             child: Container(
        //               padding: EdgeInsets.all(1),
        //               decoration: BoxDecoration(
        //                 color: Colors.red,
        //                 borderRadius: BorderRadius.circular(6),
        //               ),
        //               constraints: BoxConstraints(
        //                 minWidth: 12,
        //                 minHeight: 12,
        //               ),
        //               child: Text(
        //                 '${cartProvider.cartItems.length}',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 8,
        //                 ),
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //           );
        //   },
        // ),
        // SizedBox(
        //   width: 10,
        // ),
      ],
    );
  }
}
