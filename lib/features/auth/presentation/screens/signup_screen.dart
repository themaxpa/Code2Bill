import 'package:flutter/material.dart';
import '../../data/datasources/auth_remote_datasource.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthDatasource auth = AuthDatasource();

  bool loading = false;

  Future<void> signup() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage("Please fill all fields");
      return;
    }

    if (password != confirmPassword) {
      showMessage("Passwords do not match");
      return;
    }

    setState(() => loading = true);

    try {
      final response = await auth.signup(
        email: email,
        password: password,
        fullName: '',
      );

      if (!mounted) return;

      if (response.user != null) {
        showMessage("Account created successfully");

        // IMPORTANT:
        // DO NOT navigate manually
        // AuthGate will handle navigation
        Navigator.pop(context);

      } else {
        showMessage("Signup failed");
      }
    } catch (e) {
      showMessage("Error: ${e.toString()}");
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : signup,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Sign Up"),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}