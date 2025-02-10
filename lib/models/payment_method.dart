import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dunn_oil/models/order.dart';
import 'package:dunn_oil/provider/cart_provider.dart';
import 'package:dunn_oil/widgets/widget_order_success.dart';

class PaymentMethod {
  String? id;
  String? name;
  String? description;
  String? logo;
  String? route;
  Function? onTap;
  bool? isRouteRedirect;

  PaymentMethod({
    this.id,
    this.name,
    this.description,
    this.logo,
    this.route,
    this.onTap,
    this.isRouteRedirect,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      logo: json['logo'] as String?,
      route: json['route'] as String?,
      onTap: json['onTap'] as Function?,
      isRouteRedirect: json['isRouteRedirect'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'route': route,
      'onTap': onTap, // Note: Functions can't be serialized directly
      'isRouteRedirect': isRouteRedirect,
    };
  }
}

class PaymentMethodList {
  List<PaymentMethod>? _paymentsList;
  List<PaymentMethod>? _cashList;

  PaymentMethodList(BuildContext context) {
    _paymentsList = [
      PaymentMethod(
          id: "razorpay",
          name: "Razorpay",
          description: "Click to pay with Razorpay Method",
          logo: "assets/img/razorpay.png",
          route: "/RazorPay",
          onTap: () {},
          isRouteRedirect: false),
      PaymentMethod(
          id: "paypal",
          name: "Paypal",
          description: "Click to pay with Paypal Method",
          logo: "assets/img/paypal.png",
          route: "/PayPay",
          onTap: () {},
          isRouteRedirect: true)
    ];
    _cashList = [
      PaymentMethod(
          id: "cod",
          name: "Cash on Delivery",
          description: "Click to pay cash on delivery",
          logo: "assets/img/cash.png",
          route: "/OrderSuccess",
          onTap: () {
            var orderProvider = Provider.of<CartProvider>(context,listen: false);
            OrderModel orderModel = OrderModel();
            orderModel.paymentMethod = "cod";
            orderModel.paymentMethodTitle = "Cash on delivery";
            orderModel.setPaid = false;
            orderProvider.processOrder(orderModel);

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OrderSuccessWidget()), ModalRoute.withName('/OrderSuccess'));
          },
          isRouteRedirect: false)
    ];
  }

  List<PaymentMethod> get paymentList => _paymentsList ?? [];
  List<PaymentMethod> get cashList => _cashList ?? [];

}
