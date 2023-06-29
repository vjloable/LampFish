import 'package:flutter/material.dart';

class PaletteOne extends Color{
  static const MaterialColor primaryColor = MaterialColor(0xFFF0F0F0, <int, Color>{
    50: Color(0xFFFDFDFD),
    100: Color(0xFFFBFBFB),
    200: Color(0xFFF8F8F8),
    300: Color(0xFFF5F5F5),
    400: Color(0xFFF2F2F2),
    500: Color(0xFFF0F0F0),
    600: Color(0xFFEEEEEE),
    700: Color(0xFFECECEC),
    800: Color(0xFFE9E9E9),
    900: Color(0xFFE5E5E5),
  });

  static const MaterialColor secondaryColor = MaterialColor(0xFF3C486B, <int, Color>{
    50: Color(0xFFE8E9ED),
    100: Color(0xFFC5C8D3),
    200: Color(0xFF9EA4B5),
    300: Color(0xFF777F97),
    400: Color(0xFF596381),
    500: Color(0xFF3C486B),
    600: Color(0xFF364163),
    700: Color(0xFF2E3858),
    800: Color(0xFF27304E),
    900: Color(0xFF1A213C),
  });

  static const MaterialColor primaryAccent = MaterialColor(0xFFF9D949, <int, Color>{
    50: Color(0xFFFEFAE9),
    100: Color(0xFFFDF4C8),
    200: Color(0xFFFCECA4),
    300: Color(0xFFFBE480),
    400: Color(0xFFFADF64),
    500: Color(0xFFF9D949),
    600: Color(0xFFF8D542),
    700: Color(0xFFF7CF39),
    800: Color(0xFFF6CA31),
    900: Color(0xFFF5C021),
  });

  static const MaterialColor secondaryAccent = MaterialColor(0xFFF45050, <int, Color>{
    50: Color(0xFFFEEAEA),
    100: Color(0xFFFCCBCB),
    200: Color(0xFFFAA8A8),
    300: Color(0xFFF78585),
    400: Color(0xFFF66A6A),
    500: Color(0xFFF45050),
    600: Color(0xFFF34949),
    700: Color(0xFFF14040),
    800: Color(0xFFEF3737),
    900: Color(0xFFEC2727),
  });

  PaletteOne(super.value);
}

class PaletteTwo {
  Color primaryColor = const Color(0xFF025464);
  Color secondaryColor = const Color(0xFFF8F1F1);
  Color primaryAccent = const Color(0xFFE57C23);
  Color secondaryAccent = const Color(0xFFE8AA42);
}

class PaletteThree {
  Color primaryColor = const Color(0xFF30475E);
  Color secondaryColor = const Color(0xFF121212);
  Color primaryAccent = const Color(0xFFF5F5F5);
  Color secondaryAccent = const Color(0xFFF05454);
}




