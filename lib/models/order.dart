import 'package:dunn_oil/models/customer_detail_model.dart';

class OrderModel {
  int? customerId;
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  String? transactionId;
  List<LineItems>? lineItems;
  int? orderId;
  String? orderNumber;
  String? status;
  DateTime? orderDate;
  Shipping? shipping;

  OrderModel({
    this.customerId,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.transactionId,
    this.lineItems,
    this.orderId,
    this.orderNumber,
    this.status,
    this.orderDate,
    this.shipping,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        customerId: json['customer_id'] as int?,
        paymentMethod: json['payment_method'] as String?,
        paymentMethodTitle: json['payment_method_title'] as String?,
        setPaid: json['set_paid'] as bool?,
        transactionId: json['transaction_id'] as String?,
        lineItems: (json['line_items'] as List<dynamic>?)
            ?.map((item) => LineItems.fromJson(item))
            .toList(),
        orderId: json['id'] as int?,
        orderNumber: json['order_key'] as String?,
        status: json['status'] as String?,
        orderDate: json['date_created'] != null
            ? DateTime.parse(json['date_created'])
            : null,
        shipping: json['shipping'] != null
            ? Shipping.fromJson(json['shipping'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'payment_method': paymentMethod,
        'payment_method_title': paymentMethodTitle,
        'set_paid': setPaid,
        'transaction_id': transactionId,
        'line_items': lineItems?.map((item) => item.toJson()).toList(),
        'shipping': shipping?.toJson(),
      };
}

class LineItems {
  int? productId;
  int? quantity;
  int? variationId;

  LineItems({this.productId, this.quantity,this.variationId});

  factory LineItems.fromJson(Map<String, dynamic> json) => LineItems(
        productId: json['product_id'] as int?,
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'quantity': quantity,
        if (variationId != null) 'variation_id': variationId
      };
}

