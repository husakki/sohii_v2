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
          Container(
            margin: EdgeInsets.only(
              //top: screenHeight * 0.7,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
            ),
            child: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Image(
                image: AssetImage("assets/images/Tshirt_Parallex.png"),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image(
              image: AssetImage("assets/images/Sohii_Logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
