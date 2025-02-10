import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/provider/loader_provider.dart';
import 'package:woocommerse_app/utils/ProgressHUD.dart';
import 'package:woocommerse_app/utils/widget_checkpoints.dart';

class CheckoutBasePage extends StatefulWidget {
  const CheckoutBasePage({super.key});

  @override
  State<CheckoutBasePage> createState() => CheckoutBasePageState();
}

class CheckoutBasePageState<T extends CheckoutBasePage> extends State<T> {
  int currentPage = 0;
  bool showBackButton = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: loaderModel.isApiCallProcess,
          opacity: 0.3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                CheckPoints(
                  checkedTill: currentPage,
                  checkPoints: ["Shipping", "Paymenet", "Order"],
                ),
                Divider(
                  color: Colors.grey,
                ),
                pageUI(),
              ],
            ),
          ),
        ),
      );
    });
  }

  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: showBackButton,
      title: Text(
        "Checkout",
        style: TextStyle(color: Colors.white),
      ),
      actions: [],
    );
  }

  Widget pageUI() {
    return Container();
  }
}
