import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color green = Colors.green;

  static const Color grey = Colors.grey;
  static const Color grey01 = Color(0xFFE7E7E7);
  static const Color greyName = Color(0xFF979797);
  static const Color lightPink = Color(0xFFfcd9d9);
  static const Color grey02 = Color(0xFFF2F2F2);
  static const Color grey03 = Color(0xFFC8C7CC);
  static const Color grey04 = Color(0xFF707070);
  static const Color grey05 = Color(0xFF515151);
  static const Color grey06 = Color(0xFFC4C4C4);
  static const Color grey07 = Color(0xFF7C7C7C);

  static const Color orange = Color(0xFFFE6A5C);

  static const Color blackTundora = Color(0xFF444444);

  static Color appSecondaryColor = HexColor("#5bc5c9");
  static Color appSecondaryOrangeColor = HexColor("#bb474a");

  static const Color pink = Color(0xFFCB2F75);
  static const Color gradientColorr = Color(0xFFEC61CD);
  static const Color orangelight = Color(0xFFEC6261);
  static const Color lightGrey = Color(0xFFe6e6e6);
  static const Color darkGrey = Color(0xFF373737);

  static const Color facebookBlue = Color(0xFF4267B2);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
