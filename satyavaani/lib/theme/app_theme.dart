import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color(0xFF4D0000),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black, elevation: 0),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF800000),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
  );
}
