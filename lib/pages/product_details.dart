import 'package:flutter/material.dart';
import 'package:woocommerse_app/models/product.dart';
import 'package:woocommerse_app/pages/base_page.dart';
import 'package:woocommerse_app/widgets/widget_product_details.dart';

class ProductDetails extends BasePage {
  Product? product;
  ProductDetails({super.key,this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends BasePageState<ProductDetails> {
  
  @override
  Widget pageUI(){
    return ProductDetailsWidget(data: widget.product,);
  }
}