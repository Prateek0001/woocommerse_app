import 'package:flutter/material.dart';
import 'package:dunn_oil/api_service.dart';
import 'package:dunn_oil/models/order.dart';

class OrderProvider with ChangeNotifier{
  ApiService? _apiService;

  List<OrderModel>? _orderList;
  List<OrderModel>? get allOrders => _orderList;
  double get totalRecords => _orderList?.length.toDouble() ?? 0;

  OrderProvider(){
    resetStreams();
  }

  void resetStreams(){
    _apiService = ApiService();
  }

  fetchOrders() async {
    List<OrderModel>? orderList = await _apiService?.getOrders();
    if (orderList == null){
      _orderList = [];
    }

    if(orderList?.isNotEmpty ?? false){
      _orderList = [];
      _orderList?.addAll(orderList ??[]);
    }
    notifyListeners();
  }
}