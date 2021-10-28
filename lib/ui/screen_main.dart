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
        alignment: Alignment.center,
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
        ],
      ),
    );
  }
}
