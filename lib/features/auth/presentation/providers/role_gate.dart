import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../dashboard/presentation/screens/cashier_dashboard.dart';
import '../../../dashboard/presentation/screens/manager_dashboard.dart';
import '../../../dashboard/presentation/screens/owner_dashboard.dart';
import '../../data/datasources/profile_datasource.dart';



class RoleGate extends StatefulWidget {
  const RoleGate({super.key});

  @override
  State<RoleGate> createState() => _RoleGateState();
}

class _RoleGateState extends State<RoleGate> {
  final profileService = ProfileDatasource();

  Future<Map<String, dynamic>> getProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    final response = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', user!.id)
        .single();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text("Failed to load profile")),
          );
        }

        final profile = snapshot.data!;
        final role = profile['role'];

        switch (role) {
          case 'owner':
            return const OwnerDashboard();

          case 'manager':
            return const ManagerDashboard();

          case 'cashier':
            return const CashierDashboard();

          default:
            return const Scaffold(
              body: Center(child: Text("Access Denied")),
            );
        }
      },
    );
  }
}