import 'package:flutter/material.dart';
import 'package:sohii_v2/ui/screen_main.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      title: 'Sohii',
      home: ScreenMain(),
    );
  }
}
