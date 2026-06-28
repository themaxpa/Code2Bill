import 'package:flutter/material.dart';

class AppCardTheme {
  static CardThemeData light = CardThemeData(
    color: Colors.white,
    elevation: 6,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: const EdgeInsets.symmetric(vertical: 8),
  );

  static CardThemeData dark = CardThemeData(
    color: const Color(0xFF1E1E1E),
    elevation: 6,
    shadowColor: Colors.black45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: const EdgeInsets.symmetric(vertical: 8),
  );
}