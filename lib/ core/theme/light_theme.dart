import 'package:flutter/material.dart';
import '../../shared/widgets/app_card.dart';
import 'app_button_theme.dart';
import 'app_card_theme.dart';
import 'app_colors.dart';
import 'app_input_theme.dart';

class LightTheme {
  static ThemeData get theme => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    colorSchemeSeed: AppColors.primary,

    scaffoldBackgroundColor: AppColors.background,

    inputDecorationTheme: AppInputTheme.light,

    elevatedButtonTheme: AppButtonTheme.light,

    cardTheme: AppCardTheme.light,
  );
}