import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  // Subtle light background for screens
  scaffoldBackgroundColor: Colors.grey.shade50,
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.light(
    primary: Colors.blue, // Main blue tone for buttons, app bar, etc.
    primaryContainer: Colors.lightBlue.shade100, // Lighter blue variant
    secondary: Colors.lightBlueAccent, // Accent for highlights
    background: Colors.grey.shade50, // Subtle background
    surface: Colors.white, // Surfaces (cards, sheets) remain white
    onPrimary: Colors.white, // Text/icon color on primary elements
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    inversePrimary: Colors.blue.shade900, // Contrast color for selected elements
    tertiary: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Button background color
      foregroundColor: Colors.white, // Button text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
