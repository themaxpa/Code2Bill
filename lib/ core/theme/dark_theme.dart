import 'package:flutter/material.dart';

import 'app_button_theme.dart';
import 'app_card_theme.dart';
import 'app_colors.dart';
import 'app_input_theme.dart';

class DarkTheme {
  static ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    colorSchemeSeed: AppColors.primary,

    inputDecorationTheme: AppInputTheme.dark,

    elevatedButtonTheme: AppButtonTheme.dark,

    cardTheme: AppCardTheme.dark,
  );
}