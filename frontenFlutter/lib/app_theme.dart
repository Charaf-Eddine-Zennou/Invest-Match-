import 'package:flutter/material.dart';

class AppColors {
  static const Color yellow = Color(0xFFFACC15);
  static const Color purple = Color(0xFF1800AD);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.purple,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: AppColors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: AppColors.black,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.purple,
        primary: AppColors.purple,
        secondary: AppColors.yellow,
        error: AppColors.red,
        surface: AppColors.white,
        onPrimary: AppColors.white,
        onSecondary: AppColors.black,
        onError: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.purple,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.purple,
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.purple),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(fontFamily: 'Roboto'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.purple),
        ),
        labelStyle: TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}
