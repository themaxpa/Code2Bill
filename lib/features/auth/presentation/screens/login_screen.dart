import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_textfield.dart';
import '../../data/datasources/auth_remote_datasource.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthDatasource auth = AuthDatasource();

  bool loading = false;
  bool obscurePassword = true;

  Future<void> login() async {
    setState(() => loading = true);

    try {
      final response = await auth.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      if (response.session != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  void forgotPasswordDialog() {
    final resetEmailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Forgot Password"),
          content: TextField(
            controller: resetEmailController,
            decoration: const InputDecoration(
              labelText: "Enter your email",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await auth.forgotPassword(
                  resetEmailController.text.trim(),
                );

                if (!context.mounted) return;

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password reset email sent"),
                  ),
                );
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.qr_code_scanner,
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Login to ScanBill",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  AppCard(
                    child: Column(
                      children: [
                        AppTextField(
                          controller: emailController,
                          label: "Email",
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        AppTextField(
                          controller: passwordController,
                          label: "Password",
                          prefixIcon: Icons.lock_outline,
                          obscureText: obscurePassword,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => login(),
                          onToggleVisibility: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),

                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: forgotPasswordDialog,
                            child: const Text("Forgot Password?"),
                          ),
                        ),

                        const SizedBox(height: 10),

                        AppButton(
                          text: "Login",
                          loading: loading,
                          onPressed: login,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "© ScanBill POS",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}