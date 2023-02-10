import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sohii_v2/datatypes/product_type.dart';
import 'package:sohii_v2/model/product_model.dart';
import 'package:sohii_v2/sizeconfig.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    super.initState();
    ProductModel();
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel products = Get.put(ProductModel());

    SizeConfig().init(context);

    return FutureBuilder<List<Product>>(
      future: products.jsonProducts.value,
      builder: (context, products) {
        if (products.hasData) {
          return ListView.builder(
            itemCount: products.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        products.data![index].getProduct,
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(products.data![index].getMainColour),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(
                                      products.data![index].getMainColour),
                                  blurRadius: 570,
                                  spreadRadius: 80,
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            "assets/images/Absent.png",
                            height: 800,
                            width: 800,
                          ),
                        ],
                      ), //! For now only Absent, use this later on ${products.data![index].getProduct}
                      SizedBox(
                        height: 500,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 600,
                              child: Text(
                                "${products.data![index].getDescription}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizeSelector(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else if (products.hasError) {
          return Text("${products.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class SizeSelector extends StatefulWidget {
  const SizeSelector({
    Key? key,
  }) : super(key: key);

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
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
          height: 20,
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
