class CustomerDetailModel {
  int? id;
  String? firstName;
   String? lastName;
   Billing? billing;
   Shipping? shipping;

  CustomerDetailModel({
    this.id,
    this.firstName,
    this.lastName,
    this.billing,
    this.shipping,
  });

  factory CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailModel(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      billing: json['billing'] != null ? Billing.fromJson(json['billing']) : null,
      shipping: json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'billing': billing?.toJson(),
      'shipping': shipping?.toJson(),
    };
  }
}

class Billing {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? postcode;
  final String? country;
  final String? state;
  final String? email;
  final String? phone;

  Billing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
    this.email,
    this.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      company: json['company'] as String?,
      address1: json['address_1'] as String?,
      address2: json['address_2'] as String?,
      city: json['city'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postcode': postcode,
      'country': country,
      'state': state,
      'email': email,
      'phone': phone,
    };
  }
}

class Shipping {
   String? firstName;
   String? lastName;
   String? company;
   String? address1;
   String? address2;
   String? city;
   String? postcode;
   String? country;
   String? state;

  Shipping({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      company: json['company'] as String?,
      address1: json['address_1'] as String?,
      address2: json['address_2'] as String?,
      city: json['city'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postcode': postcode,
      'country': country,
      'state': state,
    };
  }
}
