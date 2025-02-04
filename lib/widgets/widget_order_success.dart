import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/pages/checkout_base.dart';
import 'package:woocommerse_app/pages/home_page.dart';
import 'package:woocommerse_app/provider/cart_provider.dart';

class OrderSuccessWidget extends CheckoutBasePage {
  const OrderSuccessWidget({super.key});

  @override
  State<OrderSuccessWidget> createState() => _OrderSuccessWidgetState();
}

class _OrderSuccessWidgetState extends CheckoutBasePageState<OrderSuccessWidget> {

  @override
  void initState() {
    currentPage =2;
    showBackButton  = false;
    var orderProvider = Provider.of<CartProvider>(context,listen: false);
    orderProvider.createOrder();
    super.initState();
  }

  @override
  Widget pageUI() {
    return Consumer<CartProvider>(
      builder: (context,orderModel,child){
        if(orderModel.isOrderCreated){
          return Center(
            child: Container(
              margin:EdgeInsets.only(top: 100) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.green.withOpacity(1),
                              Colors.green.withOpacity(0.2)
                            ],
                          ),
                      
                        ),
                        child: Icon(Icons.check,
                        color: Colors.white,
                        size: 90,),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Opacity(opacity: 0.6,
                  child: Text("Your order has been Successfully submitted!",textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20,),
                  // elevated button "Done"
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), ModalRoute.withName('/Home'));
                    },
                    child: Text("Done"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),

          );
        }

        return Center(child: CircularProgressIndicator(),);

      },

    );
  }

}