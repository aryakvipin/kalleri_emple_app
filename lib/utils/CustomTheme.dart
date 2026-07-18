import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  CustomTheme._();

  // Fonts
  static const String lightFont = "Kanit";
  static const String darkFont = "Winky_Sans";

  // Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color primary = Color(0xFF8B1E1E); // Temple Red
  static const Color secondary = Color(0xFFD4AF37); // Gold

  static const Color darkPrimary = Color(0xFF5C0B0B);
  static const Color darkSecondary = Color(0xFFFFD54F);

  /// Background Gradient
  static LinearGradient backgroundGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark
          ? const [
        Color(0xFF5C0B0B),
        Color(0xFF3E0707),
        Color(0xFF220202),
      ]
          : const [
        Color(0xFFA32626),
        Color(0xFF7A1414),
        Color(0xFF4D0909),
      ],
    );
  }

  /// Light Theme
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: lightFont,

    primaryColor: primary,

    scaffoldBackgroundColor: Colors.transparent,

    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: white),
      titleTextStyle: TextStyle(
        color: white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFF5E6B3),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white.withAlpha(20),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: secondary,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: black,
        minimumSize: const Size(double.infinity, 55),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withAlpha(20),
      hintStyle: const TextStyle(color: Colors.white70),
      labelStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: secondary,
          width: 2,
        ),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkPrimary,
      selectedItemColor: secondary,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
    ),

    bottomAppBarTheme: const BottomAppBarThemeData(
      surfaceTintColor: Colors.transparent,
      color: darkPrimary,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(secondary),
      trackColor:
      WidgetStateProperty.all(primary.withAlpha(180)),
    ),
  );

  /// Dark Theme
  static ThemeData get darkTheme => lightTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
  );
}