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

/// Responsive utility class using MediaQuery for proper mobile/web scaling
class Responsive {
  final BuildContext context;
  late final double width;
  late final double height;
  late final double textScale;

  Responsive(this.context) {
    final mq = MediaQuery.of(context);
    width = mq.size.width;
    height = mq.size.height;
    textScale = mq.textScaler.scale(1.0);
  }

  // Breakpoints
  bool get isSmallPhone => width < 360;
  bool get isMobile => width < 768;
  bool get isTablet => width >= 768 && width < 1200;
  bool get isDesktop => width >= 1200;

  // Responsive value helper - returns different values based on screen size
  T value<T>({
    required T mobile,
    T? smallPhone,
    T? tablet,
    T? desktop,
  }) {
    if (isSmallPhone && smallPhone != null) return smallPhone;
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // Responsive font size - scales with screen width
  double fontSize(double baseSize) {
    if (isSmallPhone) return baseSize * 0.85;
    if (isMobile) return baseSize * 0.9;
    if (isTablet) return baseSize * 0.95;
    return baseSize;
  }

  // Responsive spacing
  double spacing(double baseSpacing) {
    if (isSmallPhone) return baseSpacing * 0.6;
    if (isMobile) return baseSpacing * 0.75;
    if (isTablet) return baseSpacing * 0.9;
    return baseSpacing;
  }

  // Horizontal padding
  double get horizontalPadding {
    if (isDesktop) return 120;
    if (isTablet) return 60;
    if (isSmallPhone) return 16;
    return 24;
  }

  // Vertical section padding
  double get sectionVerticalPadding {
    if (isDesktop) return 100;
    if (isTablet) return 80;
    if (isSmallPhone) return 40;
    return 60;
  }

  // Grid cross axis count
  int get gridCrossAxisCount {
    if (isDesktop) return 3;
    if (isTablet) return 2;
    return 1;
  }

  // Card border radius
  double get cardRadius {
    if (isSmallPhone) return 12;
    if (isMobile) return 16;
    return 20;
  }

  // Icon sizes
  double get iconSize {
    if (isSmallPhone) return 20;
    if (isMobile) return 22;
    return 24;
  }

  // Button padding
  EdgeInsets get buttonPadding {
    if (isSmallPhone) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
    if (isMobile) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    }
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
  }

  // Static methods for backward compatibility
  static bool isMobileStatic(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTabletStatic(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 768 && w < 1200;
  }

  static bool isDesktopStatic(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getHorizontalPadding(BuildContext context) {
    return Responsive(context).horizontalPadding;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    return Responsive(context).gridCrossAxisCount;
  }
}
