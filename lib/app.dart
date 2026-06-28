import 'package:flutter/material.dart';
import ' core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ScanBill',

      // THEME SYSTEM
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // START SCREEN
      home: const SplashScreen(),
    );
  }
}