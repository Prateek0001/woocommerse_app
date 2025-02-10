import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dunn_oil/api_service.dart';
import 'package:dunn_oil/models/product.dart';
import 'package:dunn_oil/pages/base_page.dart';
import 'package:dunn_oil/provider/products_provider.dart';
import 'package:dunn_oil/widgets/widget_product_card.dart';

class ProductPage extends BasePage {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  int _page = 1;
  ScrollController _scrollController = new ScrollController();
  final _searchQuery = new TextEditingController();
  Timer? _debounce;

  final _sortByOptions = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("modified", "Latest", "asc"),
    SortBy("price", "Price: High to Low", "desc"),
    SortBy("popularity", "Price: Low to High", "asc"),
  ];

  @override
  void initState() {
    var productList = Provider.of<ProductsProvider>(context, listen: false);
    productList.resetStreams();
    productList.setLoadingState(LoadMoreStatus.INITIAL);
    productList.fetchProducts(_page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productList.setLoadingState(LoadMoreStatus.LOADING);
        productList.fetchProducts(++_page);
      }
    });
    _searchQuery.addListener(_onSearchChange);
    super.initState();
  }

  _onSearchChange() {
    var productList = Provider.of<ProductsProvider>(context, listen: false);
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      productList.resetStreams();
      productList.setLoadingState(LoadMoreStatus.INITIAL);
      productList.fetchProducts(_page, strSearch: _searchQuery.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _productList();
  }

  // @override
  // Widget? pageUI() {
  //   return _productList();
  // }

  Widget _productList() {
    return Consumer<ProductsProvider>(builder: (context, productsModel, child) {
      if (productsModel.allProducts != null &&
          productsModel.allProducts!.isNotEmpty &&
          productsModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
        return _buildList(productsModel.allProducts,
            productsModel.getLoadMoreStatus() == LoadMoreStatus.LOADING);
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget _buildList(List<Product>? items, bool isLoadMore) {
    return Column(
      children: [
        _productFilters(),
        Flexible(
            child: GridView.count(
          shrinkWrap: true,
          controller: _scrollController,
          crossAxisCount: 2,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: items!.map((Product item) {
            return ProductCard(data: item);
          }).toList(),
        )),
        Visibility(
            visible: isLoadMore,
            child: Container(
              padding: EdgeInsets.all(5),
              height: 35,
              width: 35,
              child: CircularProgressIndicator(),
            ))
      ],
    );
  }

  Widget _productFilters() {
    return Container(
      height: 51,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _searchQuery,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              fillColor: Colors.grey.shade200,
              filled: true,
            ),
          )),
          SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(9)),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                var productList =
                    Provider.of<ProductsProvider>(context, listen: false);
                productList.resetStreams();
                productList.setSortOrder(sortBy);
                productList.fetchProducts(_page);
              },
              itemBuilder: (BuildContext context) {
                return _sortByOptions.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: Container(
                      child: Text(item.text),
                    ),
                  );
                }).toList();
              },
              icon: Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }
}
