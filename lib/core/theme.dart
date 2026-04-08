import 'package:flutter/material.dart';

class ThyTheme {
  static const Color bannerBackground = Color(0xFF232B38);
  static const Color accentRed = Color(0xFFC90119);
  static const Color appBackground = Color(0xFFD9D9D9);
  
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: appBackground,
    primaryColor: accentRed,
    fontFamily: 'Roboto', // Defaulting to Roboto, will use Google Fonts if available
  );
}
