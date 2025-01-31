class Product {
  final int? id;
  final String? name;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final String? description;
  final String? shortDescription;
  final List<Images>? images;
  final List<Categories>? categories;
  final String? sku;
  final String? stockStatus;

  Product({
    this.id,
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
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      regularPrice: json['regular_price'] as String?,
      salePrice: json['sale_price'] as String?,
      description: json['description'] as String?,
      shortDescription: json['short_description'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((img) => Images.fromJson(img))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((cat) => Categories.fromJson(cat))
          .toList(),
      sku: json['sku'] as String?,
      stockStatus: json['stock_status'] as String?,
    );
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
