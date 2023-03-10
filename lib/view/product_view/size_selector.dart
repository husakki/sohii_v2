import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohii_v2/model/shopping_cart.dart';

import '../datatypes/size.dart';

// TODO make all vals with underscore
class SizeSelector extends StatefulWidget {
  SizeSelector({Key? key, required this.product}) : super(key: key);

  final String? product;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int lCount = 0;
  int mCount = 0;
  int sCount = 0;
  int xlCount = 0;

  get sum => sCount + mCount + lCount + xlCount;

  void vorbestellReset() {
    setState(() {
      sCount = 0;
      mCount = 0;
      lCount = 0;
      xlCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShoppingCart sc = Get.put(ShoppingCart());

    return Column(
      children: [
        SizedBox(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizeButton(
                prodSize: "S",
                counter: sCount,
                onChanged: (value) {
                  setState(() {
                    sCount = value;
                  });
                },
              ),
              SizeButton(
                prodSize: "M",
                counter: mCount,
                onChanged: (value) {
                  setState(() {
                    mCount = value;
                  });
                },
              ),
              SizeButton(
                prodSize: "L",
                counter: lCount,
                onChanged: (value) {
                  setState(() {
                    lCount = value;
                  });
                },
              ),
              SizeButton(
                prodSize: "XL",
                counter: xlCount,
                onChanged: (value) {
                  setState(() {
                    xlCount = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 42, // ~ there is just something about that number ~ Hdonger
        ),
        SizedBox(
          width: 500,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              if (sCount > 0) {
                sc.addToCart(Item(
                    product: widget.product!, size: Size.S, amount: sCount));
              }
              if (mCount > 0) {
                sc.addToCart(Item(
                    product: widget.product!, size: Size.M, amount: mCount));
              }
              if (lCount > 0) {
                sc.addToCart(Item(
                    product: widget.product!, size: Size.L, amount: lCount));
              }
              if (xlCount > 0) {
                sc.addToCart(Item(
                    product: widget.product!, size: Size.XL, amount: xlCount));
              }
              sc.printItems();
              vorbestellReset();
            },
            child: Text("Vorbestellen ($sum)"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 100,
          height: 25,
          child: ElevatedButton(
            onPressed: () {
              vorbestellReset();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Reset"),
          ),
        ),
      ],
    );
  }
}

class SizeButton extends StatefulWidget {
  SizeButton(
      {Key? key,
      required this.prodSize,
      required this.counter,
      required this.onChanged})
      : super(key: key);

  int counter;
  final ValueChanged<int> onChanged;
  final String prodSize;

  @override
  State<SizeButton> createState() => _SizeButtonState();
}

class _SizeButtonState extends State<SizeButton> with TickerProviderStateMixin {
  late AnimationController _addController;
  late AnimationController _removeController;

  @override
  void dispose() {
    _addController.dispose();
    _removeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _addController = AnimationController(
        vsync: this, value: 0, duration: const Duration(seconds: 1));
    _removeController = AnimationController(
        vsync: this, value: 0, duration: const Duration(seconds: 1));
  }

  void _addOne() {
    setState(() {
      print("add Press");
      TickerFuture tmp = _addController.forward();
      tmp.whenComplete(() => _addController.reset());
    });
    widget.onChanged(widget.counter += 1);
  }

  void _removeOne() {
    if (widget.counter > 0) {
      setState(() {
        print("rem Press");
        TickerFuture tmp = _removeController.forward();
        tmp.whenComplete(() => _removeController.reset());
      });
      widget.onChanged(widget.counter -= 1);
    } else {
      //TODO add an animation for this aswell!
      print("value to small");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
          onTap: () {
            _addOne();
          },
          onLongPress: () {
            _removeOne();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                widget.prodSize,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              //TODO make the animation smoother and nicer etc.
              AnimatedBuilder(
                animation: _addController,
                builder: (context, _) {
                  double slideUp = -30 * _addController.value;
                  double opacity = _addController.value;
                  return Transform.translate(
                    offset: Offset(0, slideUp),
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: opacity,
                        child: const Text("+1")),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _removeController,
                builder: (context, _) {
                  double slideUp = 30 * _removeController.value;
                  double opacity = _removeController.value;
                  return Transform.translate(
                    offset: Offset(0, slideUp),
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: opacity,
                        child: const Text("-1")),
                  );
                },
              ),
            ],
          )),
    );
  }
}
