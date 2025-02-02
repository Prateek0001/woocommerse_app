import 'package:flutter/material.dart';
import 'package:woocommerse_app/api_service.dart';
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

  ApiService? apiService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget pageUI(){
    return widget.product?.type == "variable" ? _variableProductList() : ProductDetailsWidget(data: widget.product,);
  }

  Widget _variableProductList(){
    apiService = ApiService();
    return FutureBuilder(
      future: apiService?.getVariableProducts(widget.product?.id ?? 0),
       builder: (context,model){
        if (model.hasData){
          return ProductDetailsWidget(data: widget.product,variableProduct: model.data,);
        }

        return Center(child: CircularProgressIndicator(),);
       }
       );
  }
}