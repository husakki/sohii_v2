import 'package:flutter/material.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Positioned(
            height: screenHeight,
            child: const Image(
              image: AssetImage("assets/images/Tshirt_Parallex.png"),
            ),
          ),
          Positioned(
            top: screenHeight * 0.05,
            child: const Image(
              image: AssetImage("assets/images/Sohii_Logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
