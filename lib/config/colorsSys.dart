// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ColorsSys {

  static Color pink = const Color(0xFFEE2C77);
  static Color green = const Color(0xFF47BD96);
  static Color orange  = const Color(0xFFE74040);
  static Color sky = const Color(0xFFCBE4E8);
  static Color blue = const Color(0xFF1E2B6C);
  static Color black = const Color(0xFF1D1D1B);
  static Color colorMed = const Color(0xFF228B22);
  static Color colorSer = const Color(0xFFFF8C00);
  static Color colorLoi = const Color(0xFFB22222);
  static Color colorPog = const Color(0xFF1E90FF);

  static const MaterialColor pinkSy = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFEE2C77),
      100: Color(0xFFEE2C77),
      200: Color(0xFFEE2C77),
      300: Color(0xFFEE2C77),
      400: Color(0xFFEE2C77),
      500: Color(_bluePrimaryValue),
      600: Color(0xFFEE2C77),
      700: Color(0xFFEE2C77),
      800: Color(0xFFEE2C77),
      900: Color(0xFFEE2C77),
    },
  );
  static const int _bluePrimaryValue = 0xFFEE2C77;
}