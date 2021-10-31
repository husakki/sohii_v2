import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohii_v2/datatypes/product_type.dart';
import 'package:sohii_v2/model/product_model.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    ProductModel();
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel products = Get.put(ProductModel());

    return FutureBuilder<List<Product>>(
      future: products.jsonProducts.value,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: screenHeight * 0.2,
                  width: screenWidth,
                  child: const Image(
                    fit: BoxFit.fitWidth,
                    image: AssetImage("assets/images/Tshirt_Parallex.png"),
                  ),
                ),
                Positioned(
                  top: screenHeight * -0.07,
                  child: Image(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.75,
                    image: const AssetImage("assets/images/Sohii_Logo.png"),
                  ),
                ),
                Positioned(
                  //! getting weird errors | before it was left 0 right 0 and without center
                  child: Center(child: Text(snapshot.data![0].product)),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
