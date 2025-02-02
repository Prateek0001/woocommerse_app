import 'package:woocommerse_app/models/variable_product.dart';

class Product {
  int? id;
  final String? name;
  String? price;
  final String? regularPrice;
  final String? salePrice;
  final String? description;
  final String? shortDescription;
  final String? sku;
  final String? stockStatus;
  final List<Images>? images;
  final List<Categories>? categories;
  final List<Attributes>? attributes;
  String? type;
  VariableProduct? variableProduct;

  Product(
      {this.id,
      this.name,
      this.price,
      this.regularPrice,
      this.description,
      this.shortDescription,
      this.images,
      this.categories,
      this.sku,
      this.stockStatus,
      this.salePrice,
      this.attributes,
      this.type,
      this.variableProduct});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int?,
        name: json['name'] as String?,
        price: json['price'] as String?,
        regularPrice: json['regular_price'] as String?,
        salePrice: json['sale_price'] != ""
            ? json['sale_price'] as String?
            : json['regular_price'] as String?,
        description: json['description'] as String?,
        shortDescription: json['short_description'] as String?,
        images: (json['images'] as List<dynamic>?)
            ?.map((img) => Images.fromJson(img))
            .toList(),
        categories: (json['categories'] as List<dynamic>?)
            ?.map((cat) => Categories.fromJson(cat))
            .toList(),
        attributes: (json['attributes'] as List<dynamic>?)
            ?.map((attr) => Attributes.fromJson(attr))
            .toList(),
        sku: json['sku'] as String?,
        stockStatus: json['stock_status'] as String?,
        type: json['type'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'description': description,
      'short_description': shortDescription,
      'images': images?.map((img) => img.toJson()).toList(),
      'categories': categories?.map((cat) => cat.toJson()).toList(),
      'sku': sku,
      'stock_status': stockStatus,
    };
  }

  calculateDiscount() {
    double disPercent = 0;
    if (regularPrice != "") {
      double regularPrice = double.parse(this.regularPrice ?? '0');
      double salePrice = this.salePrice != ""
          ? double.parse(this.salePrice ?? '')
          : regularPrice;
      double discount = regularPrice - salePrice;
      disPercent = (discount / regularPrice) * 100;
    }
    return disPercent.round();
  }
}

class Categories {
  final int? id;
  final String? name;

  Categories({this.id, this.name});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Images {
  final String? src;

  Images({this.src});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      src: json['src'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'src': src,
    };
  }
}

class Attributes {
  final int id;
  final String name;
  final String slug;
  final int position;
  final bool visible;
  final bool variation;
  final List<String> options;

  Attributes({
    required this.id,
    required this.name,
    required this.slug,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      position: json['position'] ?? 0,
      visible: json['visible'] ?? false,
      variation: json['variation'] ?? false,
      options: (json['options'] as List<dynamic>?)
              ?.map((option) => option.toString())
              .toList() ??
          [],
    );
  }
}
