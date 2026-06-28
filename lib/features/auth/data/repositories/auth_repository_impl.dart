import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class AuthDatasource {
  final SupabaseClient _client = SupabaseConfig.client;

  // LOGIN
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // SIGNUP (ONLY AUTH - NO PROFILE INSERT)
  Future<AuthResponse> signup({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName, // optional metadata
      },
    );

    return response;
  }

  // FORGOT PASSWORD
  Future<void> forgotPassword(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.supabase.scanbill://reset-callback',
    );
  }

  // LOGOUT
  Future<void> logout() async {
    await _client.auth.signOut();
  }

  // CURRENT USER
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  // CURRENT SESSION
  Session? getCurrentSession() {
    return _client.auth.currentSession;
  }
}