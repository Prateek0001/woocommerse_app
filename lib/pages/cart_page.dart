import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/provider/cart_provider.dart';
import 'package:woocommerse_app/provider/loader_provider.dart';
import 'package:woocommerse_app/utils/ProgressHUD.dart';
import 'package:woocommerse_app/widgets/widget_cart_product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    var cartItemsList = Provider.of<CartProvider>(context, listen: false);
    //cartItemsList.resetStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderModel, child) {
        return Scaffold(
          body: ProgressHUD(
            child: _cartItemsList(),
            inAsyncCall: loaderModel.isApiCallProcess,
            opacity: 0.3,
          ),
        );
      },
    );
  }

  Widget _cartItemsList() {
    return Consumer<CartProvider>(builder: (context, cartModel, child) {
      if (cartModel.cartItems.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartModel.cartItems.length,
                itemBuilder: (context, index) {
                  return CartProduct(
                    data: cartModel.cartItems[index],
                  );
                }
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                ]
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rs ${cartModel.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Checkout logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Checkout', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        );
      }
      return Center(child: Text("Your cart is empty"));
    });
  }
}
