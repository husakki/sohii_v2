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
    _items.add(newItem);
    print(_items);
  }

  //TODO fix needed
  //! This is probly bad. please fix it
  @override
  String toString() {
    String tmp = "";
    for (Item element in _items) {
      tmp += element.toString();
    }
    return tmp;
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
