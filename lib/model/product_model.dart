import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:sohii_v2/datatypes/product_type.dart';

/// This class gets the information about the avail. products from the json file
class ProductModel extends GetxController {
  final jsonProducts = Future.value(<Product>[]).obs;

  @override
  void onInit() {
    super.onInit();
    fetchList();
  }

  Future<List<Product>> callApi() async {
    String jsonString = await _loadFromAsset();
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    List<Product> jsonProducts = [];
    jsonResponse.forEach((key, value) {
      jsonProducts.add(
          Product(value['Product'], value['Description'], value['MainColor']));
    });
    return jsonProducts;
  }

  void fetchList() async {
    jsonProducts.value = callApi();
  }

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/json/products.json");
  }
}
