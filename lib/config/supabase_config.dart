import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://urzjievvetdecmlcuxzh.supabase.co',

      // ✅ REQUIRED FOR FLUTTER APPS
      publishableKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyemppZXZ2ZXRkZWNtbGN1eHpoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODI1NzE1MzEsImV4cCI6MjA5ODE0NzUzMX0.bgJK3SvgSp8Z5NIgP0NokNNGxTZvhqi71oT79JwKjrE',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}