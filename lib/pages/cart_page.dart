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
    cartItemsList.resetStreams();
    cartItemsList.fetchCartItems();
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
      if (cartModel.cartItems != null && cartModel.cartItems.length > 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cartModel.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartProduct(
                        data: cartModel.cartItems[index],
                      );
                    }),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<LoaderProvider>(context,listen: false).setLoadingStatus(true);
                        var cartProvider = Provider.of<CartProvider>(context,listen: false);

                        cartProvider.updateCart((val){
                          Provider.of<LoaderProvider>(context,listen: false).setLoadingStatus(false);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8, // Space between icon and text
                        children: [
                          Icon(
                            Icons.sync,
                            color: Colors.white,
                          ),
                          Text(
                            'Update Cart',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            Text('Rs ${cartModel.totalAmount}',style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                        ElevatedButton(onPressed: (){}, child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Checkout',style: TextStyle(color: Colors.white),)
                          ],
                        ))
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        );
      }
      return const Center(
        child: Text("Your cart is empty"),
      );
    });
  }
}
