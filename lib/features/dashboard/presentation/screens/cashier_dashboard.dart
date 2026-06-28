import 'package:flutter/material.dart';

class CashierDashboard extends StatelessWidget {
  const CashierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Cashier Dashboard",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}