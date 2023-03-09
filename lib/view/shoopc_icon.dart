import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/shopping_cart.dart';

class ShoppingCartIcon extends StatefulWidget {
  const ShoppingCartIcon({Key? key}) : super(key: key);

  @override
  State<ShoppingCartIcon> createState() => _ShoppingCartIconState();
}

class _ShoppingCartIconState extends State<ShoppingCartIcon> {
  @override
  Widget build(BuildContext context) {
    final ShoppingCart sc = Get.put(ShoppingCart());
    return Stack(
      children: [
        const SizedBox(
          width: 45,
          height: 45,
        ),
        const Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 35.0,
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(child: Obx(() => Text("${sc.numbOfItems}"))),
          ),
        ),
      ],
    );
  }
}
