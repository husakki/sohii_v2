// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../datatypes/size.dart';

class ShoppingCart extends GetxController {
  List<Item> _items = <Item>[].obs;

  int get numbOfItems {
    int result = 0;

    for (Item item in _items) {
      result += item.amount;
    }

    return result;
  }

  void addToCart(Item newItem) {
    if (notContainsProductAndSize(newItem)) {
      _items.add(newItem);
    } else {}

    printItems();
  }

  void printItems() {
    for (Item element in _items) {
      print(element);
    }
  }

  bool notContainsProductAndSize(Item newItem) {
    return true;
  }
}

class Item {
  String product;
  Size size;
  int amount;
  Item({
    required this.product,
    required this.size,
    required this.amount,
  });

  @override
  String toString() =>
      'Item(product: $product, size: $size, amount: $amount) \n';
}
