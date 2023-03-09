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
    if (containsProductAndSize(newItem)) {
      Item tmp = groupSameItems(newItem);
      _items.add(tmp);
    } else {
      // just add it
      _items.add(newItem);
    }

    printItems();
  }

  void printItems() {
    for (Item element in _items) {
      print(element);
    }
  }

  bool containsProductAndSize(Item newItem) {
    bool result = false;
    for (Item element in _items) {
      if (element.product == newItem.product && element.size == newItem.size) {
        return true;
      }
    }
    return result;
  }

  Item groupSameItems(Item newItem) {
    Item tmp;
    int totalAmount = 0;
    // sum of all in the list
    for (Item element in _items) {
      if (element.product == newItem.product && element.size == newItem.size) {
        totalAmount += element.amount;
      }
    }
    // add the new one
    totalAmount += newItem.amount;

    //remove dups from the list
    _items.removeWhere((element) =>
        element.product == newItem.product && element.size == newItem.size);
    // create new item
    tmp =
        Item(product: newItem.product, size: newItem.size, amount: totalAmount);

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
