import 'package:flutter/material.dart';

class ColorUI {
  static const Color PRIMARY_COLOR = const Color(0xFF07000F);
  static const Color SECONDARY_COLOR = const Color(0xFFA2A2A2);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color BLACK = Color(0xFF000000);
  static const Color BLUE = Color(0xFF3874F0);
  static const Color GREEN = Color(0xFF00B75B);
  static const Color RED = Color(0xFFF80000);
}

TextStyle PRIMARY_TEXT_STYLE = const TextStyle(color: ColorUI.PRIMARY_COLOR);
TextStyle SECONDARY_TEXT_STYLE =
    const TextStyle(color: ColorUI.SECONDARY_COLOR);
TextStyle BLACK_TEXT_STYLE = const TextStyle(color: ColorUI.BLACK);
TextStyle WHITE_TEXT_STYLE = const TextStyle(color: ColorUI.WHITE);

class FontUI {
  static const FontWeight WEIGHT_LIGHT = FontWeight.w400;
  static const FontWeight WEIGHT_MEDIUM = FontWeight.w500;
  static const FontWeight WEIGHT_SEMI_BOLD = FontWeight.w600;
  static const FontWeight WEIGHT_BOLD = FontWeight.w700;
}
