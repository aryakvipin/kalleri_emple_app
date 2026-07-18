import 'package:flutter/material.dart';

class AppColors {
  static const maroon = Color(0xFF6B1E23);
  static const maroonDark = Color(0xFF4A1418);
  static const background = Color(0xFFF4EFE6);
  static const card = Color(0xFFF7F2E9);
  static const gold = Color(0xFFC9A24B);
  static const confirmedBg = Color(0xFFF3E3B2);
  static const confirmedText = Color(0xFF8A6D1E);
  static const closedBg = Color(0xFFB0242C);
  static const closedText = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF2A2A2A);
  static const textMuted = Color(0xFF7A7A7A);
  static const darkMaroon = Color(0xFF5C0A0A);
  static const cream = Color(0xFFFDF3EC);
  static const lightPink = Color(0xFFFBEAE6);
  static const textGrey = Color(0xFF8A7A72);


  static const Color creamCard = Color(0xFFF6EDE0);

  static const Color confirmedGreen = Color(0xFF2E7D32);
  static const Color confirmedGreenBg = Color(0xFFE3F3E4);
  static const Color pendingOrange = Color(0xFFB07A1E);
  static const Color pendingOrangeBg = Color(0xFFFCEFD3);

  // ---- Added: used by profile_page.dart / donation_details_page.dart ----
  static const Color cardWhite = Color(0xFFFFFFFF);

  // Donation "Completed" status pill — reuses the existing confirmed-green pair.
  static const Color greenBg = confirmedGreenBg;
  static const Color greenText = confirmedGreen;

  // Donation "In Progress" status pill — reuses the existing pending-orange pair.
  static const Color orangeBg = pendingOrangeBg;
  static const Color orangeText = pendingOrange;
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.maroon,
        primary: AppColors.maroon,
        background: AppColors.cream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.maroon,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.maroon,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.maroon, width: 1.5),
        ),
      ),
    );
  }
}