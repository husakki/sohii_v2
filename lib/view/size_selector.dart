import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// TODO make all vals with underscore
class SizeSelector extends StatefulWidget {
  SizeSelector({Key? key, required this.product}) : super(key: key);
  final String? product;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int sCount = 0;

  int mCount = 0;

  int lCount = 0;

  int xlCount = 0;

  @override
  Widget build(BuildContext context) {
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
              ),
              SizeButton(
                prodSize: "M",
                counter: mCount,
              ),
              SizeButton(
                prodSize: "L",
                counter: lCount,
              ),
              SizeButton(
                prodSize: "XL",
                counter: xlCount,
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
              print(sCount);
            },
            child: const Text("Vorbestellen"),
          ),
        ),
      ],
    );
  }
}

class SizeButton extends StatefulWidget {
  SizeButton({Key? key, required this.prodSize, required this.counter})
      : super(key: key);

  final String prodSize;
  int counter;

  @override
  State<SizeButton> createState() => _SizeButtonState();
}

class _SizeButtonState extends State<SizeButton> with TickerProviderStateMixin {
  late AnimationController _addController;
  late AnimationController _removeController;
  // compensation for flutter_animate package
  bool isBuild = false;
  bool isAddPress = false;
  bool isRemPress = false;

  @override
  void initState() {
    super.initState();
    _addController = AnimationController(
      vsync: this,
      value: 0,
    );
    _removeController = AnimationController(
      vsync: this,
      value: 0,
    );
  }

  @override
  void dispose() {
    _addController.dispose();
    _removeController.dispose();
    super.dispose();
  }

  void _addOne() {
    setState(() {
      isAddPress = true;
      isBuild = true;
      _addController.forward();
      widget.counter++;
    });
  }

  void _removeOne() {
    setState(() {
      isRemPress = true;
      isBuild = true;
      _removeController.forward();
      widget.counter--;
    });
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
              const Center(child: Text("+1"))
                  .animate(
                    controller: _addController,
                    onPlay: (controller) {
                      if (!isBuild || isRemPress) controller.stop();
                    },
                    onComplete: (controller) {
                      controller.reset();
                      isAddPress = false;
                    },
                  )
                  .fadeIn(duration: 300.ms)
                  .slideY(end: -2)
                  .then()
                  .fadeOut(),
              const Center(child: Text("-1"))
                  .animate(
                    controller: _removeController,
                    onPlay: (controller) {
                      if (!isBuild || isAddPress) _removeController.stop();
                    },
                    onComplete: (controller) {
                      _removeController.reset();
                      isRemPress = false;
                    },
                  )
                  .fadeIn(duration: 300.ms)
                  .slideY(end: 2)
                  .then()
                  .fadeOut()
            ],
          )),
    );
  }
}
