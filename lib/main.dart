import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dunn_oil/config.dart';
import 'package:dunn_oil/pages/base_page.dart';
import 'package:dunn_oil/pages/cart_page.dart';
import 'package:dunn_oil/pages/home_page.dart';
import 'package:dunn_oil/pages/login_page.dart';
import 'package:dunn_oil/pages/orders_page.dart';
import 'package:dunn_oil/pages/product_details.dart';
import 'package:dunn_oil/pages/product_page.dart';
import 'package:dunn_oil/pages/signup_page.dart';
import 'package:dunn_oil/provider/cart_provider.dart';
import 'package:dunn_oil/provider/loader_provider.dart';
import 'package:dunn_oil/provider/order_provider.dart';
import 'package:dunn_oil/provider/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider(),
        child: ProductPage(),),

        ChangeNotifierProvider(create: (context) => LoaderProvider(),
        child: BasePage(),),

        ChangeNotifierProvider(create: (context) => CartProvider(),
        child: ProductDetails(),),

        ChangeNotifierProvider(create: (context) => CartProvider(),
        child: CartPage(),),

        ChangeNotifierProvider(create: (context) => OrderProvider(),
        child: OrdersPage(),),
      ],
      child: MaterialApp(
        title: Config.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}

