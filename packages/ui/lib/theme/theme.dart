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
      cardColor: Colors.grey.shade200,
      scaffoldBackgroundColor: GreenPalColors.white,
      textTheme: GreenPalFonts.lightTextTheme,
      useMaterial3: false,
    );
  }

  /// Dark default theme color scheme
  static ThemeData dark() {
    return ThemeData(
      colorScheme: const ColorScheme.dark().copyWith(
        primary: GreenPalColors.darkPrimary,
        secondary: GreenPalColors.darkSecondary,
        error: GreenPalColors.red,
        surface: GreenPalColors.darkerText,
      ),
      primaryColor: GreenPalColors.primary,
      appBarTheme: const AppBarTheme(elevation: 0),
      scaffoldBackgroundColor: GreenPalColors.darkerText,
      cardColor: GreenPalColors.darkText,
      textTheme: GreenPalFonts.darkTextTheme,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: GreenPalColors.darkText,
        selectedItemColor: GreenPalColors.primary,
        unselectedItemColor: GreenPalColors.lightText,
      ),
      useMaterial3: false,
    );
  }
}
