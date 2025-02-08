import 'package:flutter/material.dart';
import 'package:woocommerse_app/api_service.dart';
import 'package:woocommerse_app/models/cart_response_model.dart';
import 'package:woocommerse_app/models/customer_detail_model.dart';
import 'package:woocommerse_app/models/order.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  CustomerDetailModel? _customerDetailModel;
  OrderModel? _orderModel;
  bool _isOrderCreated = false;

  List<CartItem> get cartItems => _cartItems;
  double get totalRecords => _cartItems.length.toDouble();
  double get totalAmount => _cartItems.isNotEmpty
      ? _cartItems.fold(
          0,
          (sum, item) =>
              sum +
              (double.parse(item.productSalePrice ??
                      item.productRegularPrice ??
                      "0") *
                  (item.qty ?? 1)))
      : 0;
  CustomerDetailModel? get customerDetailModel => _customerDetailModel;
  OrderModel? get orderModel => _orderModel;
  bool get isOrderCreated => _isOrderCreated;

  void resetStreams() {
    _cartItems = [];
    notifyListeners();
  }

  void addToCart(CartItem product) {
    var existingItem = _cartItems.firstWhere(
      (item) =>
          item.productId == product.productId &&
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

  fetchShippingDetails() async {
    ApiService _apiService = ApiService();
    if (_customerDetailModel == null) {
      _customerDetailModel = CustomerDetailModel();
    }

    _customerDetailModel = await _apiService.customerDetails();
    notifyListeners();
  }

  processOrder(OrderModel orderModel) {
    _orderModel = orderModel;
    notifyListeners();
  }

  void createOrder() async {
    if (_orderModel?.shipping == null) {
      _orderModel?.shipping = Shipping();
    }

    if (customerDetailModel?.shipping != null) {
      _orderModel?.shipping = customerDetailModel?.shipping;
    }
    if (orderModel?.lineItems == null) {
      _orderModel?.lineItems = <LineItems>[];
    }

    _cartItems.forEach((v) {
      _orderModel?.lineItems?.add(LineItems(
          productId: v.productId, quantity: v.qty, variationId: v.variationId));
    });

    await ApiService().createOrder(orderModel).then((value) => {
      if (value) {
        _isOrderCreated = true,
        notifyListeners()
      }
    });
  }

  void updateCustomerDetails(CustomerDetailModel model) {
    _customerDetailModel = model;
    notifyListeners();
  }
}
