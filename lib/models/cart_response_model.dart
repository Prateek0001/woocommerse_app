class CartResponseModel {
  bool? status;
  List<CartItem>? data;

  CartResponseModel({this.status, this.data});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>?)?.map((item) => CartItem.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem {
  int? productId;
  String? productName;
  String? productRegularPrice;
  String? productSalePrice;
  String? thumbnail;
  int? qty;
  double? lineSubtotal;
  double? lineTotal;

  CartItem({
    this.productId,
    this.productName,
    this.productRegularPrice,
    this.productSalePrice,
    this.thumbnail,
    this.qty,
    this.lineSubtotal,
    this.lineTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'] as int?,
      productName: json['product_name'] as String?,
      productRegularPrice: json['product_regular_price'] as String?,
      productSalePrice: json['product_sale_price'] as String?,
      thumbnail: json['thumbnail'] as String?,
      qty: json['qty'] as int?,
      lineSubtotal: (json['line_subtotal'] as num?)?.toDouble(),
      lineTotal: (json['line_total'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_regular_price': productRegularPrice,
      'product_sale_price': productSalePrice,
      'thumbnail': thumbnail,
      'qty': qty,
      'line_subtotal': lineSubtotal,
      'line_total': lineTotal,
    };
  }
}