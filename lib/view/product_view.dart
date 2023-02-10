import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohii_v2/datatypes/product_type.dart';
import 'package:sohii_v2/model/product_model.dart';
import 'package:sohii_v2/sizeconfig.dart';

import 'size_selector.dart';

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
                            SizeSelector(
                                product: products.data![index].getProduct),
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
