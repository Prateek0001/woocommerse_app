import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/models/cart_request_model.dart';
import 'package:woocommerse_app/models/product.dart';
import 'package:woocommerse_app/models/variable_product.dart';
import 'package:woocommerse_app/provider/cart_provider.dart';
import 'package:woocommerse_app/provider/loader_provider.dart';
import 'package:woocommerse_app/utils/custom_stepper.dart';
import 'package:woocommerse_app/utils/expand_text.dart';

class ProductDetailsWidget extends StatelessWidget {
  Product? data;
  List<VariableProduct>? variableProduct;
  ProductDetailsWidget({super.key, this.data, this.variableProduct});

  final CarouselSliderController _controller = CarouselSliderController();
  int qty = 0;

  CartProducts cartProducts = CartProducts();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  productImages(data?.images ?? [], context),
                  SizedBox(
                    height: 5,
                  ),
                  Text(data?.name ?? '',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: data?.type != "variable",
                        child: Text(data?.attributes != null &&
                                data!.attributes!.isNotEmpty
                            ? (data!.attributes![0].options
                                    .join("-")
                                    .toString() +
                                "" +
                                data!.attributes![0].name)
                            : ''),
                      ),
                      Visibility(
                          visible: data?.type == "variable",
                          child: selectDropdown(context, "", variableProduct,
                              (VariableProduct value) {
                            data?.price = value.price;
                            data?.variableProduct = value;
                          })),
                      Text(' Rs${data?.price}',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomStepper(
                          lowerLimit: 0,
                          upperLimit: 20,
                          stepValue: 1,
                          iconSize: 22.0,
                          value: qty,
                          onChanged: (value) {
                            cartProducts.quantity = value;
                          }),
                      TextButton(
                        onPressed: () {
                          Provider.of<LoaderProvider>(context, listen: false)
                              .setLoadingStatus(true);
                              
                          var cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProducts.productId = data?.id;
                          cartProducts.variationId = data?.variableProduct != null ? data?.variableProduct?.id : 0;

                          cartProvider.addToCart(cartProducts, (val) {
                            Provider.of<LoaderProvider>(context, listen: false)
                                .setLoadingStatus(false);
                            print(val);
                          });
                        },
                        child: Container(
                          color: Colors.redAccent,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ExpandText(
                      labelHeader: "Product Details",
                      desc: data?.description ?? '',
                      shortDesc: data?.shortDescription ?? '')
                ])
          ],
        ),
      ),
    );
  }

  Widget productImages(List<Images> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              child: CarouselSlider.builder(
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 1.0),
                  itemCount: images.length,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return Container(
                      child: Center(
                        child: Image.network(
                          images[index].src ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  })),
          Positioned(
              top: 100,
              child: IconButton(
                  onPressed: () {
                    _controller.previousPage();
                  },
                  icon: Icon(Icons.arrow_back_ios))),
          Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width - 80,
              child: IconButton(
                  onPressed: () {
                    _controller.nextPage();
                  },
                  icon: Icon(Icons.arrow_forward_ios)))
        ],
      ),
    );
  }

  static Widget selectDropdown(
    BuildContext context,
    Object initialValue,
    dynamic data,
    Function onChanged, {
    Function? onValidate,
  }) {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: 75,
          width: 100,
          padding: EdgeInsets.only(top: 5),
          child: DropdownButtonFormField<VariableProduct>(
            hint: Text("Select"),
            value: null,
            isDense: true,
            decoration: fieldDecoration(context, "", ""),
            onChanged: (VariableProduct? newValue) {
              FocusScope.of(context).requestFocus(FocusNode());
              onChanged(newValue);
            },
            items: data != null
                ? data.map<DropdownMenuItem<VariableProduct>>(
                    (VariableProduct data) {
                    return DropdownMenuItem<VariableProduct>(
                        value: data,
                        child: Text(
                            "${data.attributes?.first.option} ${data?.attributes?.first?.name}",
                            style: TextStyle(color: Colors.black)));
                  }).toList()
                : null,
          ),
        ));
  }

  static InputDecoration fieldDecoration(
      BuildContext context, String hintText, String helperText,
      {Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(6),
        hintText: hintText,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1)));
  }
}
