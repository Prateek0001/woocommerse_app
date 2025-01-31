import 'package:flutter/material.dart';
import 'package:woocommerse_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade200, blurRadius: 15, spreadRadius: 10)
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Visibility(
            //   visible: data.calculateDiscount()>0,
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: Container(
            //       padding: EdgeInsets.all(5),
            //       decoration: BoxDecoration(
            //         color: Colors.green,
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //       child: Text(
            //         '${data.calculateDiscount()}% OFF',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.w700
            //         ),
            //       ),
            //     ),
            //   )),
            Flexible(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                  ),
                  Image.network(
                    data.images!.isNotEmpty
                        ? data.images![0].src ?? ''
                        : "https://en.m.wikipedia.org/wiki/File:No_image_available.svg",
                    height: 160,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: data.salePrice != data.regularPrice,
                  child: Text(
                    'Rs ${data.regularPrice}',
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  'Rs ${data.salePrice}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
