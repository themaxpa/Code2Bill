import 'package:flutter/material.dart';
import 'login_screen.dart';
// later we will create signup screen
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.qr_code_scanner,
              size: 90,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            const Text(
              "Welcome to ScanBill",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Smart Billing & Inventory System",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 50),

            // LOGIN BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text("Login"),
              ),
            ),

            const SizedBox(height: 10),

            // SIGNUP BUTTON
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}