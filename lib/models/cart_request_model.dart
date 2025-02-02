class CartRequestModel {
  int? userId;
  List<CartProducts>? products;

  CartRequestModel({
    this.userId,
    this.products,
  });

  factory CartRequestModel.fromJson(Map<String, dynamic> json) {
    return CartRequestModel(
      userId: json['user_id'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((product) => CartProducts.fromJson(product as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'products': products?.map((product) => product.toJson()).toList(),
    };
  }
}

class CartProducts {
  int? productId;
  int? quantity;
  int? variationId = 0;

  CartProducts({
    this.productId,
    this.quantity,
    this.variationId
  });

  factory CartProducts.fromJson(Map<String, dynamic> json) {
    return CartProducts(
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
      variationId: json['variation_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'variation_id' : variationId,
    };
  }
}
