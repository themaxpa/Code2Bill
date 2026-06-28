class SupabaseExceptionHandler {
  static String handle(dynamic e) {
    final msg = e.toString();

    if (msg.contains('Invalid login credentials')) {
      return "Wrong email or password";
    }

    if (msg.contains('duplicate key')) {
      return "User already exists";
    }

    if (msg.contains('network')) {
      return "Network error. Check internet";
    }

    return "Something went wrong";
  }
}