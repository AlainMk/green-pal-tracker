import 'package:flutter/material.dart';
import 'package:green_pal_ui/theme/colors.dart';
import 'package:green_pal_ui/theme/fonts.dart';

class GreenPalTheme {
  /// Light default theme color scheme
  static ThemeData light() {
    return ThemeData(
      colorScheme: const ColorScheme.light().copyWith(
        primary: GreenPalColors.primary,
        secondary: GreenPalColors.secondary,
        error: GreenPalColors.red,
        surface: GreenPalColors.white,
      ),
      primaryColor: GreenPalColors.primary,
      appBarTheme: const AppBarTheme(
        backgroundColor: GreenPalColors.white,
        elevation: 0,
        foregroundColor: GreenPalColors.darkerText,
      ),
      scaffoldBackgroundColor: GreenPalColors.white,
      textTheme: GreenPalFonts.lightTextTheme,
      useMaterial3: false,
    );
  }
}
