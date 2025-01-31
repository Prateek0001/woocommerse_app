import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/pages/home_page.dart';
import 'package:woocommerse_app/pages/login_page.dart';
import 'package:woocommerse_app/pages/product_page.dart';
import 'package:woocommerse_app/pages/signup_page.dart';
import 'package:woocommerse_app/provider/products_provider.dart';

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
        child: ProductPage(),)
      ],
      child: MaterialApp(
        title: 'WooCommerce App',
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

