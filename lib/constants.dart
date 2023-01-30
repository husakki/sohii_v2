import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Sora',
  scaffoldBackgroundColor: const Color(0xff131313),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch(),
);
