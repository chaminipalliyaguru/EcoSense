import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String _keyUsername = 'username';
  static const String _keyEmail = 'email';
  static const String _keyFullName = 'full_name';
  static const String _keyContact = 'contact';

  static Future<void> saveUser({
    required String username,
    String? email,
    String? fullName,
    String? contact,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    if (email != null) await prefs.setString(_keyEmail, email);
    if (fullName != null) await prefs.setString(_keyFullName, fullName);
    if (contact != null) await prefs.setString(_keyContact, contact);
  }

  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_keyUsername) ?? 'Guest',
      'email': prefs.getString(_keyEmail) ?? 'Not set',
      'full_name': prefs.getString(_keyFullName) ?? 'Not set',
      'contact': prefs.getString(_keyContact) ?? 'Not set',
    };
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
