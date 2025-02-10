import 'package:flutter/material.dart';
import 'package:dunn_oil/api_service.dart';
import 'package:dunn_oil/models/product.dart';

class ProductsProvider with ChangeNotifier {
  ApiService? _apiService;
  List<Product>? _productList;
  SortBy? _sortBy;

  int pageSize = 10;

  List<Product>? get allProducts => _productList;
  double? get totalRecords => _productList?.length.toDouble();
  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  ProductsProvider() {
    _sortBy = SortBy("modified", "Latest", "asc");
  }

  void resetStreams() {
    _apiService = ApiService();
    _productList = [];
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fetchProducts(pageNumber,
      {String? strSearch,
      String? tagName,
      String? categoryId,
      String? sortBy,
      String? sortOrder = "asc"}) async {
        List<Product>? itemModel = await _apiService?.getProducts(
          strSearch: strSearch,
          tagName: tagName,
          pageNumber: pageNumber,
          pageSize: this.pageSize,
          categoryId: categoryId,
          sortBy: this._sortBy?.value,
          sortOrder: this._sortBy?.sortOrder
        );
        if (itemModel != null && itemModel.isNotEmpty) {
          _productList?.addAll(itemModel);
        }
        setLoadingState(LoadMoreStatus.STABLE);
        notifyListeners();
      }
}

enum LoadMoreStatus { INITIAL, LOADING, STABLE }

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}
