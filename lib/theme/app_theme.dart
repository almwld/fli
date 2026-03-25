import 'package:flutter/material.dart';

class AppColors {
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldLight = Color(0xFFF4E4C1);
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color lightCard = Colors.white;
  static const Color darkText = Colors.white;
  static const Color lightText = Color(0xFF212121);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.goldPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.goldPrimary,
      secondary: AppColors.goldLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.goldPrimary,
      foregroundColor: Colors.black,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.goldPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.goldPrimary,
      secondary: AppColors.goldLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkCard,
      foregroundColor: AppColors.goldPrimary,
      centerTitle: true,
    ),
  );

  static const Color goldColor = AppColors.goldPrimary;
  static const LinearGradient goldGradient = LinearGradient(
    colors: [AppColors.goldPrimary, AppColors.goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
