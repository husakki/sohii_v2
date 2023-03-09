import 'package:get/get.dart';

import '../datatypes/size.dart';

class ShoppingCart extends GetxController {
  List<Item> items = <Item>[].obs;

  int get numbOfItems {
    int result = 0;

    for (Item item in items) {
      result += item.amount;
    }

    return result;
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
}
