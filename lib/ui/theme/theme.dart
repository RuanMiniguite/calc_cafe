import 'package:flutter/material.dart';

class ThemeApp {
  // ======== Cores ========
  static const Color primaryColor = Color(0xFFAF8764);
  static const Color secondaryColor = Color(0xFF6F4E37);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFDFCFA);
  static const Color borderColor = Color(0xFFAF8764);

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'Roboto',

      colorScheme:
          ColorScheme.fromSeed(
            seedColor: primaryColor,
            brightness: Brightness.light,
          ).copyWith(
            primary: primaryColor,
            secondary: secondaryColor,
            surface: backgroundColor,
          ),

      scaffoldBackgroundColor: backgroundColor,

      // ===========================
      // APP BAR
      // ===========================
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // ===========================
      // TEXTOS
      // ===========================
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: secondaryColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
      ),

      // ===========================
      // CARDS
      // ===========================
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: borderColor, width: 1),
        ),
      ),

      // ===========================
      // INPUTS
      // ===========================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.grey),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),

        floatingLabelStyle: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),

      // ===========================
      // BOTÕES
      // ===========================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: secondaryColor,
          side: const BorderSide(color: secondaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryColor),
      ),

      // ===========================
      // SNACKBAR
      // ===========================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: secondaryColor,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // ===========================
      // ÍCONES
      // ===========================
      iconTheme: const IconThemeData(color: secondaryColor, size: 24),

      // ===========================
      // DIVISORES
      // ===========================
      dividerTheme: DividerThemeData(color: Colors.grey.shade300, thickness: 1),

      // ===========================
      // CHECKBOX
      // ===========================
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.white;
        }),
      ),

      // ===========================
      // CURSOR
      // ===========================
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionHandleColor: primaryColor,
        selectionColor: Color(0x55AF8764),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFAF8764),
        brightness: Brightness.dark,
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white70,
          side: const BorderSide(color: Colors.white24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
