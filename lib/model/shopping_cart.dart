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
      Item groupedItem = groupSameItems(newItem);
      _items.add(groupedItem);
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

  /// groups by product and size and sums up the amount to return one item with the sum of all.
  Item groupSameItems(Item newItem) {
    Item tmp;
    List<Item> tmpItems = [..._items];

    tmpItems.removeWhere((element) =>
        !(element.product == newItem.product && element.size == newItem.size));

    int totalAmount = tmpItems.fold(newItem.amount,
        (previousValue, element) => previousValue + element.amount);

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
