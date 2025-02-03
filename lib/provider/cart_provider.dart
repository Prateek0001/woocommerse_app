import 'package:flutter/material.dart';
import 'package:woocommerse_app/models/cart_response_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;
  double get totalRecords => _cartItems.length.toDouble();
  double get totalAmount => _cartItems.isNotEmpty
      ? _cartItems.fold(0, (sum, item) => 
          sum + (double.parse(item.productSalePrice ?? item.productRegularPrice ?? "0") * (item.qty ?? 1)))
      : 0;

  void resetStreams() {
    _cartItems = [];
    notifyListeners();
  }

  void addToCart(CartItem product) {
    var existingItem = _cartItems.firstWhere(
      (item) => item.productId == product.productId && 
                item.variationId == product.variationId,
      orElse: () => CartItem(),
    );

    if (existingItem.productId != null) {
      existingItem.qty = (existingItem.qty ?? 0) + (product.qty ?? 1);
    } else {
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void updateQty(int productId, int qty, {int variationId = 0}) {
    var item = _cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItem(),
    );

    if (item.productId != null) {
      item.qty = qty;
      notifyListeners();
    }
  }

  void removeItem(int productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = [];
    notifyListeners();
  }

  void updateCart(Function onCallback) {
    notifyListeners();
    onCallback();
  }
}
