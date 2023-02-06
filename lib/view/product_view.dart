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

class _SizeButtonState extends State<SizeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
          onTap: () {
            _startAnimation();
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
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              )
                  .animate(
                    controller: _controller,
                    onComplete: (controller) => controller.reset(),
                  )
                  .fadeIn(duration: 300.ms)
                  .slideY(end: -2)
                  .then()
                  .fadeOut()
            ],
          )),
    );
  }
}
