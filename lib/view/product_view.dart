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
  @override
  void initState() {
    super.initState();
    ProductModel();
  }

  //TODO make a sizeconfig in rootdir so I dont have to do this in every Screen
  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    final ProductModel products = Get.put(ProductModel());

    return FutureBuilder<List<Product>>(
      future: products.jsonProducts.value,
      builder: (context, products) {
        if (products.hasData) {
          return ListView.builder(
            // TODO need to make a getx object to share the controller with the screen
            //TODO main and make it react to it.
            // controller: ,
            itemCount: products.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      products.data![index].getProduct,
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(products.data![index].getMainColour),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/Absent.png",
                        height: 800,
                        width: 800,
                      ), //! For now only Absent, use this later on ${products.data![index].getProduct}
                      Column(
                        children: [
                          Container(
                            width: 400,
                            child:
                                Text("${products.data![index].getDescription}"),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text("S"),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("M"),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("L"),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("XL"),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Vorbestellen"),
                          ),
                          Text(
                              "${products.data![index].getProductInformation}"),
                        ],
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
