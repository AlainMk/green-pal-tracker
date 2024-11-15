import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class GreenPalFonts {
  const GreenPalFonts._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      color: GreenPalColors.darkerText,
      height: 0.5,
    ),
    displayMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      color: GreenPalColors.darkerText,
    ),
    displaySmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: GreenPalColors.darkerText,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: GreenPalColors.darkerText,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: GreenPalColors.darkerText,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: GreenPalColors.darkerText,
    ),
    titleLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: GreenPalColors.darkerText,
      fontSize: 20,
    ),
    titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: GreenPalColors.darkerText,
      fontSize: 16,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: GreenPalColors.darkText,
      fontSize: 14,
    ),
    labelLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: GreenPalColors.darkText,
    ),
    labelMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: GreenPalColors.darkText,
    ),
    labelSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: GreenPalColors.lightText,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: GreenPalColors.darkText,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: GreenPalColors.darkerText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.poppins(
      color: GreenPalColors.lightText,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
  );
}
