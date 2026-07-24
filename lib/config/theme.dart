import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color palette - Hồng pastel + Trắng kem + Gold
  static const Color primaryPink = Color(0xFFFFB6C1);
  static const Color lightPink = Color(0xFFFFE4E9);
  static const Color creamWhite = Color(0xFFFFF8F0);
  static const Color goldAccent = Color(0xFFFFD700);
  static const Color deepPink = Color(0xFFFF69B4);
  static const Color roseRed = Color(0xFFFF1744);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8A8A8A);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFE53935);

  // Gradient backgrounds
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFE4E9), Color(0xFFFFF8F0), Color(0xFFFFE4E9)],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
  );

  // Text styles
  static TextStyle get displayLarge => GoogleFonts.dancingScript(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: deepPink,
  );

  static TextStyle get displayMedium => GoogleFonts.dancingScript(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: deepPink,
  );

  static TextStyle get headlineLarge => GoogleFonts.quicksand(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  static TextStyle get headlineMedium => GoogleFonts.quicksand(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static TextStyle get bodyLarge => GoogleFonts.quicksand(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textDark,
  );

  static TextStyle get bodyMedium => GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textDark,
  );

  static TextStyle get labelStyle => GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textLight,
  );

  // BoxDecoration
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: primaryPink.withOpacity(0.2),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  static BoxDecoration get keyDecoration => BoxDecoration(
    gradient: goldGradient,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: goldAccent.withOpacity(0.4),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get buttonDecoration => BoxDecoration(
    gradient: buttonGradient,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: deepPink.withOpacity(0.3),
        blurRadius: 16,
        offset: const Offset(0, 6),
      ),
    ],
  );

  // ThemeData
  static ThemeData get theme => ThemeData(
    primaryColor: primaryPink,
    scaffoldBackgroundColor: creamWhite,
    colorScheme: const ColorScheme.light(
      primary: primaryPink,
      secondary: goldAccent,
      surface: Colors.white,
      error: errorRed,
    ),
    textTheme: TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      labelLarge: labelStyle,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
      ),
    ),
    useMaterial3: true,
  );
}
