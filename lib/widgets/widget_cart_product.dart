import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/config.dart';
import 'package:woocommerse_app/models/cart_response_model.dart';
import 'package:woocommerse_app/provider/cart_provider.dart';
import 'package:woocommerse_app/provider/loader_provider.dart';
import 'package:woocommerse_app/utils/custom_stepper.dart';
import 'package:woocommerse_app/utils/utils.dart';

class CartProduct extends StatelessWidget {
  CartItem? data;
  CartProduct({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Text("Cart Item"),
      ),
    );
  }

  ListTile makeListTile(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        leading: Container(
          width: 50,
          height: 150,
          alignment: Alignment.center,
          child: Image.network(
            data?.thumbnail ?? '',
            height: 150,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            data?.productName ?? '',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(5),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                "${data?.productSalePrice.toString()}",
                style: TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  Utils.showMessage(context, Config.appName,
                      "Do you want to delete this item?", "Yes", () {
                        
                    Provider.of<LoaderProvider>(context, listen: false)
                        .setLoadingStatus(true);

                    Provider.of<CartProvider>(context, listen: false)
                        .removeItem(data?.productId ?? 0);

                    Provider.of<LoaderProvider>(context, listen: false)
                        .setLoadingStatus(false);
                  },
                      buttonText2: "No",
                      isConfirmationDiaglog: true,
                      onPressed2: () {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8), // Space between icon and text
                    Text(
                      "Remove",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        trailing: Container(
          width: 120,
          child: CustomStepper(
              lowerLimit: 0,
              upperLimit: 20,
              stepValue: 1,
              iconSize: 22.0,
              value: data?.qty ?? 0,
              onChanged: (value) {
                Provider.of<CartProvider>(context, listen: false)
                    .updateQty(data?.productId ?? 0, value);
              }),
        ),
      );
}
