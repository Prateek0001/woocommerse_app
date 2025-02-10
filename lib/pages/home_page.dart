import 'package:flutter/material.dart';
import 'package:dunn_oil/config.dart';
import 'package:dunn_oil/pages/about_page.dart';
import 'package:dunn_oil/pages/cart_page.dart';
import 'package:dunn_oil/pages/dashboard_page.dart';
import 'package:dunn_oil/pages/orders_page.dart';
import 'package:dunn_oil/pages/payment_screen.dart';
import 'package:dunn_oil/pages/product_page.dart';
import 'package:dunn_oil/widgets/widget_order_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    AboutPage(),
    ProductPage(),
    CartPage(),
    //DashboardPage(),
    OrdersPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag),label: 'Place Order'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'My Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.add_home_work),label: 'My Orders'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: false,
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
        // SizedBox(
        //   width: 10,
        // ),
      ],
    );
  }
}
