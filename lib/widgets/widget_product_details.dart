import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:woocommerse_app/models/product.dart';
import 'package:woocommerse_app/utils/custom_stepper.dart';
import 'package:woocommerse_app/utils/expand_text.dart';

class ProductDetailsWidget extends StatelessWidget {
  final Product data;
  ProductDetailsWidget({super.key, required this.data});

  final CarouselSliderController _controller = CarouselSliderController();
  int qty = 0;

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
                  productImages(data.images ?? [], context),
                  SizedBox(
                    height: 5,
                  ),
                  Text(data.name ?? '',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(data.attributes != null &&
                              data.attributes!.isNotEmpty
                          ? (data.attributes![0].options.join("-").toString() +
                              "" +
                              data.attributes![0].name)
                          : ''),
                      Text(' Rs${data.salePrice}',
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
                            print(value);
                          }),
                      TextButton(
                        onPressed: () {},
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
                      desc: data.description ?? '',
                      shortDesc: data.shortDescription ?? '')
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
}
