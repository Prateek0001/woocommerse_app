import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dunn_oil/config.dart';
import 'package:dunn_oil/models/cart_request_model.dart';
import 'package:dunn_oil/models/cart_response_model.dart';
import 'package:dunn_oil/models/customer.dart';
import 'package:dunn_oil/models/customer_detail_model.dart';
import 'package:dunn_oil/models/login_model.dart';
import 'package:dunn_oil/models/order.dart';
import 'package:dunn_oil/models/order_detail.dart';
import 'package:dunn_oil/models/product.dart';
import 'package:dunn_oil/models/variable_product.dart';

class ApiService {
  Future<bool> createCustomer(CustomerModel? model) async {
    bool ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model?.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  Future<LoginResponseModel?> loginCustomer(
      String? username, String? password) async {
    LoginResponseModel? model;

    try {
      var response = await Dio().post(Config.tokenURL,
          data: {
            "username": username,
            "password": password,
          },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          }));

      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }

    return model;
  }

  Future<List<Product>> getProducts(
      {int? pageNumber,
      int? pageSize,
      String? strSearch,
      String? tagName,
      String? categoryId,
      String? sortBy,
      String? sortOrder = "asc"}) async {
    List<Product> data = [];

    try {
      String parameter = "";
      if (strSearch != null) {
        parameter += "&search=$strSearch";
      }
      if (pageSize != null) {
        parameter += "&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }
      if (tagName != null) {
        parameter += "&tag=$tagName";
      }
      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }
      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }
      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }

      String url = Config.url + Config.productsUrl + "?" + parameter.toString();

      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 200) {
        // convert response.data to List of Product
        List<dynamic> responseData = response.data;
        data = responseData.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      print(e.toString());
    }

    return data;
  }

  Future<CartResponseModel?> addtocart(CartRequestModel model) async {
    model.userId = Config.userId;
    CartResponseModel? responseModel;
    try {
      var response = await Dio().post(Config.url + Config.addToCartURL,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return responseModel;
  }

  Future<CartResponseModel?> getCartItems() async {
    CartResponseModel? responseModel;
    try {
      String url = Config.url + Config.cartURL + "?user_id=${Config.userId}";

      print(url);

      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }

    return responseModel;
  }

  Future<List<VariableProduct>?> getVariableProducts(int productId) async {
    List<VariableProduct>? responseModel;
    try {
      String url = Config.url +
          Config.productsUrl +
          "/${productId.toString()}/${Config.variableProductsURL}";

      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 200) {
        responseModel = (response.data as List)
            .map((e) => VariableProduct.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e.toString());
    }
    return responseModel;
  }

  Future<CustomerDetailModel?> customerDetails() async {
    CustomerDetailModel? responseModel;
    try {
      String url = Config.url + Config.customerURL + "/${Config.userId}";
      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 200) {
        responseModel = CustomerDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return responseModel;
  }

  Future<bool> createOrder(OrderModel? model) async {
    model?.customerId = Config.userId;
    bool isOrderCreated = false;
    try {
      var response = await Dio().post(Config.url + Config.orderURL,
          data: model?.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 201) {
        isOrderCreated = true;
      }
    } catch (e) {
      print(e.toString());
    }
    return isOrderCreated;
  }

  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> data = [];
    try {
      String url = Config.url + Config.orderURL;

      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 200) {
        data =
            (response.data as List).map((i) => OrderModel.fromJson(i)).toList();
      }
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

  Future<OrderDetailModel> getOrderDetails(int orderId) async {
    OrderDetailModel responseModel = OrderDetailModel();
    try {
      String url = Config.url + Config.orderURL + "/$orderId";
      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic ${Config.authToken}',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 200) {
        responseModel = OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }

    return responseModel;
  }
}
