import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDatasource {
  final _client = Supabase.instance.client;

  Future<Map<String, dynamic>> getProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return response;
  }
}