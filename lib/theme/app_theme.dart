import 'package:flutter/material.dart';

class AppTheme {
  // Gradient colors - lighter purple theme
  static const Color darkPurple = Color(0xFF2D1B4E); // Dark purple at top
  static const Color mediumPurple = Color(0xFF6B4C9A); // Medium purple
  static const Color lightPurple = Color(0xFF9C7BB5); // Light purple
  static const Color accentPink = Color(0xFFE91E63);
  static const Color accentOrange = Color(0xFFFF6F00);

  // UI colors
  static const Color cardPurple = Color(0xFF7B5BA1);
  static const Color cardPurpleLight = Color(0xFF9B7BC1);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGray = Color(0xFFE0E0E0);

  // Legacy colors for compatibility
  static const Color primaryPurple = darkPurple;
  static const Color secondaryPurple = mediumPurple;

  // Gradient - lighter purple theme
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      darkPurple, // Dark purple at top
      mediumPurple, // Medium purple in middle
      lightPurple, // Light purple at bottom
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cardPurple, cardPurpleLight],
  );

  // Theme data
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: primaryPurple,
      colorScheme: const ColorScheme.dark(
        primary: primaryPurple,
        secondary: accentPink,
        surface: cardPurple,
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textWhite,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        iconTheme: IconThemeData(color: textWhite),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: cardPurple.withOpacity(0.6),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: textWhite.withOpacity(0.2), width: 1),
        ),
      ),

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cardPurple,
          foregroundColor: textWhite,
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: textWhite.withOpacity(0.3), width: 2),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textWhite,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textWhite,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textWhite,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textWhite,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textWhite,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(color: textWhite, fontSize: 16),
        bodyMedium: TextStyle(color: textGray, fontSize: 14),
        labelLarge: TextStyle(
          color: textWhite,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: textWhite.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: textWhite.withOpacity(0.3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentPink, width: 2),
        ),
        hintStyle: TextStyle(color: primaryPurple.withOpacity(0.6)),
        labelStyle: const TextStyle(
          color: primaryPurple,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
