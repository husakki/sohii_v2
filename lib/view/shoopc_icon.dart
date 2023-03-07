import 'package:flutter/material.dart';

class ShoppingCartIcon extends StatefulWidget {
  const ShoppingCartIcon({Key? key}) : super(key: key);

  @override
  State<ShoppingCartIcon> createState() => _ShoppingCartIconState();
}

class _ShoppingCartIconState extends State<ShoppingCartIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Positioned(
      top: 30.0,
      right: 30.0,
      child: Icon(
        Icons.shopping_cart,
        color: Colors.white,
        size: 35.0,
      ),
    ));
  }
}
