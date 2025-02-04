import 'package:woocommerse_app/models/customer_detail_model.dart';

class OrderDetailModel {
  int? orderId;
  String? orderNumber;
  String? paymentMethod;
  String? orderStatus;
  DateTime? orderDate;
  Shipping? shipping;
  List<LineItems>? lineItems;
  double? totalAmount;
  double? shippingTotal;
  double? itemTotalAmount;

  OrderDetailModel({
    this.orderId,
    this.orderNumber,
    this.paymentMethod,
    this.orderStatus,
    this.orderDate,
    this.shipping,
    this.lineItems,
    this.totalAmount,
    this.shippingTotal,
    this.itemTotalAmount,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    var lineItems = (json['line_items'] as List<dynamic>?)
        ?.map((item) => LineItems.fromJson(item as Map<String, dynamic>))
        .toList();
        
    return OrderDetailModel(
        orderId: json['id'] as int?,
        orderNumber: json['order_key'] as String?,
        paymentMethod: json['payment_method_title'] as String?,
        orderStatus: json['status'] as String?,
        orderDate: json['date_created'] != null
            ? DateTime.parse(json['date_created'])
            : null,
        shipping: json['shipping'] != null
            ? Shipping.fromJson(json['shipping'] as Map<String, dynamic>)
            : null,
        lineItems: lineItems,
        totalAmount: double.parse(json['total']),
        shippingTotal: double.parse(json['shipping_total']),
        itemTotalAmount: lineItems?.fold<double>(
          0,
          (sum, item) => sum + (item.totalAmount ?? 0),
        ) ?? 0,
      );
  }

  Map<String, dynamic> toJson() => {
        'id': orderId,
        'order_key': orderNumber,
        'payment_method_title': paymentMethod,
        'status': orderStatus,
        'date_created': orderDate?.toIso8601String(),
        'shipping': shipping?.toJson(),
        'line_items': lineItems?.map((item) => item.toJson()).toList(),
        'total': totalAmount,
        'shipping_total': shippingTotal,
        'itemTotalAmount': itemTotalAmount,
      };
}

class LineItems {
  int? productId;
  String? productName;
  int? quantity;
  int? variationId;
  double? totalAmount;

  LineItems({
    this.productId,
    this.productName,
    this.quantity,
    this.variationId,
    this.totalAmount,
  });

  factory LineItems.fromJson(Map<String, dynamic> json) => LineItems(
        productId: json['product_id'] as int?,
        productName: json['name'] as String?,
        quantity: json['quantity'] as int?,
        variationId: json['variation_id'] as int?,
        totalAmount: double.parse(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'quantity': quantity,
        'variationId': variationId,
        'totalAmount': totalAmount,
      };
}


