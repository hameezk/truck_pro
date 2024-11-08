import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static ThemeData themeData() {
    return ThemeData(
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins(
            fontSize: 40,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.poppins(
            fontSize: 28,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.normal),
        headlineSmall: GoogleFonts.poppins(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w400,
            fontSize: 15),
      ),
    );
  }
}
