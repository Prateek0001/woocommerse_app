import 'package:flutter/material.dart';
import 'package:woocommerse_app/api_service.dart';
import 'package:woocommerse_app/models/cart_request_model.dart';
import 'package:woocommerse_app/models/cart_response_model.dart';

class CartProvider with ChangeNotifier {
  ApiService? _apiService;
  List<CartItem>? _cartItems;

  List<CartItem> get cartItems => _cartItems ?? [];
  double get totalRecords => _cartItems?.length.toDouble() ?? 0;
  double get totalAmount => _cartItems != null
      ? _cartItems!
          .map<double>((e) => e.lineSubtotal ?? 0)
          .reduce((value, element) => value + element)
      : 0;

  CartProvider() {
    _apiService = ApiService();
    _cartItems = List.empty();
  }

  void resetStreams() {
    _apiService = ApiService();
    _cartItems = List.empty();
  }

  void addToCart(CartProducts product, Function onCallback) async {
    try {
      CartRequestModel requestModel = CartRequestModel();
      requestModel.products = [];

      if (_cartItems == null) {
        await fetchCartItems();
      }

      _cartItems?.forEach((element) {
        requestModel.products?.add(
            CartProducts(productId: element.productId, quantity: element.qty,variationId: element.variationId));
      });

      var isProductExists = requestModel.products?.firstWhere(
        (prd) => prd.productId == product.productId && prd.variationId == product.variationId,
        orElse: () => CartProducts(),
      );

      if (isProductExists != null) {
        requestModel.products?.remove(isProductExists);
      }

      requestModel.products?.add(product);

      await _apiService?.addtocart(requestModel).then((cartResponseModel) {
        if (cartResponseModel?.data != null) {
          _cartItems = [];
          _cartItems?.addAll(cartResponseModel?.data ?? []);
        }
        onCallback(cartResponseModel);
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  fetchCartItems() async {
    if (_cartItems == null) resetStreams();

    await _apiService?.getCartItems().then((cartResponseModel) {
      if (cartResponseModel?.data != null) {
        _cartItems?.addAll(cartResponseModel?.data ?? []);
      }

      notifyListeners();
    });
  }

  void updateQty(int productId, int qty,{int variationId = 0}) {
    var isProductExists = _cartItems?.firstWhere(
        (prd) => prd.productId == productId && prd.variationId == variationId,
        orElse: () => CartItem());

    if (isProductExists != null) {
      isProductExists.qty = qty;
    }
    notifyListeners();
  }

  void updateCart(Function onCallback) async {
    CartRequestModel requestModel = CartRequestModel();
    requestModel.products = [];

    if (_cartItems == null) resetStreams();

    _cartItems?.forEach((element) {
      requestModel.products?.add(
          CartProducts(productId: element.productId, quantity: element.qty,variationId: element.variationId));
    });

    await _apiService?.addtocart(requestModel).then((cartResponseModel) {
      if (cartResponseModel?.data != null) {
        _cartItems = [];
        _cartItems?.addAll(cartResponseModel?.data ?? []);
      }
      onCallback(cartResponseModel);
      notifyListeners();
    });
  }

  void removeItem(int productId){
    var isProductExists = _cartItems?.firstWhere((prd) => prd.productId == productId , orElse: () => CartItem(),);

    if (isProductExists != null){
      _cartItems?.remove(isProductExists);
    }

    notifyListeners();
  }

}
