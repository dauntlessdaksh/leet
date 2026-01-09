import 'package:flutter/material.dart';

class AppTheme {
  // Colors from Android app
  static const Color primaryColor = Color(0xFFFFA116); // LeetCode Orange
  static const Color primaryDark = Color(0xFFB37410);
  
  static const Color bgNeutral = Color(0xFF282828); // Dark grey background
  static const Color cardBg = Color(0xFF333333);    // Slightly lighter for cards
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFBDBDBD);
  
  static const Color easyColor = Color(0xFF00B8A3);
  static const Color mediumColor = Color(0xFFFFC01E);
  static const Color hardColor = Color(0xFFFF375F);
  
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bgNeutral,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: primaryColor,
      surface: cardBg,
      // background: bgNeutral, // Deprecated
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: textPrimary,
      // onBackground: textPrimary, // Deprecated
    ),
    /* cardTheme: CardTheme(
      color: cardBg,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ), */
    appBarTheme: const AppBarTheme(
      backgroundColor: bgNeutral,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: textPrimary),
      bodyMedium: TextStyle(color: textSecondary),
      labelLarge: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ), // Button text
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor),
      ),
      hintStyle: const TextStyle(color: textSecondary),
      prefixIconColor: textSecondary,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
    ),
  );
}
