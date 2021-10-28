import 'dart:convert';

class Product {
  final String product;
  final String description;
  final String productInformation;
  final String mainColour;

  Product(
      this.product, this.description, this.productInformation, this.mainColour);

  get getProduct => product;

  get getDescription => description;

  get getProductInformation => productInformation;

  get getMainColour => mainColour;

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'description': description,
      'productInformation': productInformation,
      'mainColour': mainColour,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['product'],
      map['description'],
      map['productInformation'],
      map['mainColour'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
