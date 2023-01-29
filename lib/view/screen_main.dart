import 'package:flutter/material.dart';
import 'package:sohii_v2/view/product_view.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  //TODO make a sizeconfig in rootdir so I dont have to do this in every Screen
  late ScrollController _scrollController;

  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double get offset =>
      _scrollController.hasClients ? _scrollController.offset : 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Positioned(
          //   top: screenHeight * 0.2,
          //   width: screenWidth,
          //   child: const Image(
          //     fit: BoxFit.fitWidth,
          //     image: AssetImage("assets/images/Tshirt_Parallex.png"),
          //   ),
          // ),
          // Positioned(
          //   top: screenHeight * -0.07,
          //   child: Image(
          //     height: screenHeight * 0.6,
          //     width: screenWidth * 0.75,
          //     image: const AssetImage("assets/images/Sohii_Logo.png"),
          //   ),
          // ),
          ProductView(),
        ],
      ),
    );
  }
}
