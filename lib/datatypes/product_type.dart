// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Map<String, Product> productFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Product>(k, Product.fromJson(v)));

String productToJson(Map<String, Product> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Product {
  Product({
    required this.product,
    required this.description,
    required this.productInformation,
    required this.mainColor,
  });

  String product;
  String description;
  String productInformation;
  String mainColor;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: json["Product"],
        description: json["Description"],
        productInformation: json["ProductInformation"],
        mainColor: json["MainColor"],
      );

  Map<String, dynamic> toJson() => {
        "Product": product,
        "Description": description,
        "ProductInformation": productInformation,
        "MainColor": mainColor,
      };
}
