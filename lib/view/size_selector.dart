import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({Key? key, required this.product}) : super(key: key);
  final String? product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              SizeButton(prodSize: "S"),
              SizeButton(prodSize: "M"),
              SizeButton(prodSize: "L"),
              SizeButton(prodSize: "XL"),
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
            onPressed: () {},
            child: const Text("Vorbestellen"),
          ),
        ),
      ],
    );
  }
}

class SizeButton extends StatefulWidget {
  const SizeButton({Key? key, required this.prodSize}) : super(key: key);

  final String prodSize;

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
    });
  }

  void _removeOne() {
    setState(() {
      isRemPress = true;
      isBuild = true;
      _removeController.forward();
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
