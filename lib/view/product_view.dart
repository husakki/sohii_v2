import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohii_v2/datatypes/product_type.dart';
import 'package:sohii_v2/model/product_model.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  //TODO make a sizeconfig in rootdir so I dont have to do this in every Screen
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
      builder: (context, jsonContent) {
        if (jsonContent.hasData) {
          return ListView.builder(
            // TODO need to make a getx object to share the controller with the screen
            //TODO main and make it react to it.
            // controller: ,
            itemCount: jsonContent.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  //TODO need to be moved above the listview builder
                  // Container(
                  //   height: screenHeight,
                  // ),
                  Container(
                    // height: 500,
                    child: Text("${jsonContent.data![index].product}"),
                  ),
                ],
              );
            },
          );
        } else if (jsonContent.hasError) {
          return Text("${jsonContent.error}");
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
