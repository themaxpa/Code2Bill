import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/presentation/providers/auth_gate.dart';
import '../../../auth/presentation/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startApp();
  }

  void startApp() async {
    await Future.delayed(const Duration(seconds: 2));

    final session = Supabase.instance.client.auth.currentSession;

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => session != null
            ? const AuthGate()
            : const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code_scanner,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              "ScanBill",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Smart Billing System",
              style: TextStyle(
                color: Colors.white70,
              ),
            )
          ],
        ),
      ),
    );
  }
}