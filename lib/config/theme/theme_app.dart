import 'package:flutter/material.dart';

class ThemeApp {
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xFF2563EB),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2563EB),
      secondary: Color(0xFF17192D),
      surface: Colors.white,
      onSurface: Colors.blueGrey,
      primaryContainer: Color(0xFFEAEFF3),
      error: Colors.red,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF17192D),
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: _outlineBorder,
      errorBorder: _outlineBorder,
      enabledBorder: _outlineBorder,
      focusedBorder: _outlineBorder,
      disabledBorder: _outlineBorder,
      focusedErrorBorder: _outlineBorder,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color.fromARGB(220, 23, 25, 45),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    sliderTheme: SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
  );

  static final _outlineBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(12),
  );
}
