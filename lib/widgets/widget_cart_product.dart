import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dunn_oil/config.dart';
import 'package:dunn_oil/models/cart_response_model.dart';
import 'package:dunn_oil/provider/cart_provider.dart';
import 'package:dunn_oil/provider/loader_provider.dart';
import 'package:dunn_oil/utils/custom_stepper.dart';
import 'package:dunn_oil/utils/utils.dart';

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
        child: makeListTile(context),
      ),
    );
  }

  ListTile makeListTile(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        // leading: Container(
        //   width: 50,
        //   height: 150,
        //   alignment: Alignment.center,
        //   child: Image.network(
        //     data?.thumbnail ?? '',
        //     height: 150,
        //   ),
        // ),
        title: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            data?.variationId == 0
                ? data?.productName ?? ''
                : "${data?.productName} (${data?.attributeValue}${data?.attribute})",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(5),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                "${Config.currency} ${data?.productSalePrice.toString()}",
                style: TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  Utils.showMessage(
                    context, 
                    Config.appName,
                    "Do you want to delete this item?", 
                    "Yes", 
                    () {
                      Provider.of<CartProvider>(context, listen: false)
                          .removeItem(data?.productId ?? 0);
                      Navigator.of(context).pop();
                    },
                    buttonText2: "No",
                    isConfirmationDiaglog: true,
                    onPressed2: () {
                      Navigator.of(context).pop();
                    }
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 4), // Space between icon and text
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
                    .updateQty(data?.productId ?? 0, value,variationId: data?.variationId ?? 0);
              }),
        ),
      );
}
