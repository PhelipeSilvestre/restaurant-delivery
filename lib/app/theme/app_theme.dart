// TODO Implement this library.
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
    primaryColor: Color(0xFF6200EE),
    hintColor: Color(0xFF03DAC6),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF6200EE),
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
    primaryColor: Color(0xFFBB86FC),
    hintColor: Color(0xFF03DAC6),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFBB86FC),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
