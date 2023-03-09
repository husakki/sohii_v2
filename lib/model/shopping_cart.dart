import 'package:get/get.dart';

import '../datatypes/size.dart';

class ShoppingCart extends GetxController {
  List<Item> items = <Item>[].obs;

  int get numbOfItems {
    return items.length;
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
