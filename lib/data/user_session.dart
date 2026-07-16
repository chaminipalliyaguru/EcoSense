import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String _keyUsername = 'username';
  static const String _keyEmail = 'email';
  static const String _keyFullName = 'full_name';
  static const String _keyContact = 'contact';
  static const String _keyToken = 'token';

  static Future<void> saveUser({
    required String username,
    String? email,
    String? fullName,
    String? contact,
    String? token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    if (email != null) await prefs.setString(_keyEmail, email);
    if (fullName != null) await prefs.setString(_keyFullName, fullName);
    if (contact != null) await prefs.setString(_keyContact, contact);
    if (token != null) await prefs.setString(_keyToken, token);
  }

  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_keyUsername) ?? 'Guest',
      'email': prefs.getString(_keyEmail) ?? '',
      'full_name': prefs.getString(_keyFullName) ?? '',
      'contact': prefs.getString(_keyContact) ?? '',
      'token': prefs.getString(_keyToken) ?? '',
    };
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
