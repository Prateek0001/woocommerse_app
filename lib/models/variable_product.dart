class VariableProduct {
  int? id;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  List<Attributes>? attributes;

  VariableProduct({
    this.id,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.attributes,
  });

  factory VariableProduct.fromJson(Map<String, dynamic> json) {
    return VariableProduct(
      id: json['id'] as int?,
      sku: json['sku'] as String?,
      price: json['price'] as String?,
      regularPrice: json['regular_price'] as String?,
      salePrice: json['sale_price'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)?.map((item) => Attributes.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'attributes': attributes?.map((item) => item.toJson()).toList(),
    };
  }
}

class Attributes {
  int? id;
  String? name;
  String? option;

  Attributes({
    this.id,
    this.name,
    this.option,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      id: json['id'] as int?,
      name: json['name'] as String?,
      option: json['option'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'option': option,
    };
  }
}
