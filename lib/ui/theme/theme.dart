import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData light() {
    return ThemeData(
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),

      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Roboto',
        ),
      ),

      cardTheme: CardThemeData(
        color:  Color.fromARGB(255, 253, 252, 249), // Cor de fundo do Card
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Color.fromARGB(200, 175, 135, 100),
            width: 1,
          ),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF6F4E37),
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
