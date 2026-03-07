import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF00D9FF);
  static const Color accentColor = Color(0xFFFF6B6B);
  static const Color darkBg = Color(0xFF0A0E21);
  static const Color cardBg = Color(0xFF1D1E33);
  static const Color lightText = Color(0xFFFFFFFF);
  static const Color subtleText = Color(0xFFB0B0B0);

  static final LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardBg,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.poppins(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: lightText,
            ),
            displayMedium: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: lightText,
            ),
            headlineLarge: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: lightText,
            ),
            headlineMedium: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: lightText,
            ),
            titleLarge: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: lightText,
            ),
            bodyLarge: GoogleFonts.poppins(fontSize: 16, color: subtleText),
            bodyMedium: GoogleFonts.poppins(fontSize: 14, color: subtleText),
          ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: lightText,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getHorizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 120;
    if (isTablet(context)) return 60;
    return 24;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }
}
