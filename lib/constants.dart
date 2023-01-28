import 'package:flutter/material.dart';

//TODO fix deprecation
ThemeData mainTheme = ThemeData(
  fontFamily: 'Sora',
  scaffoldBackgroundColor: const Color(0xff131313),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch(),
);
