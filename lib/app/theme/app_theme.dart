// TODO Implement this library.
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
    primaryColor: const Color(0xFF6200EE),
    hintColor: const Color(0xFF03DAC6),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF6200EE),
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
    primaryColor: const Color(0xFFBB86FC),
    hintColor: const Color(0xFF03DAC6),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFBB86FC),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
