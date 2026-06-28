import 'package:flutter/material.dart';
import 'app_input_theme.dart';
import 'app_button_theme.dart';
import 'app_card_theme.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffF5F7FB),

    inputDecorationTheme: AppInputTheme.light,
    elevatedButtonTheme: AppButtonTheme.light,
    cardTheme: AppCardTheme.light,
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,

    inputDecorationTheme: AppInputTheme.dark,
    elevatedButtonTheme: AppButtonTheme.dark,
    cardTheme: AppCardTheme.dark,
  );
}