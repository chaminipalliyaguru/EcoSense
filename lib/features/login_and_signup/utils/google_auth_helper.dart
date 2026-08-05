import 'package:flutter/material.dart';

class GoogleAuthHelper {
  /*
  // Disabled Google Auth configuration
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '425105073862-26c3u02977evqohntkvveeqri630kvrm.apps.googleusercontent.com',
  );
  */

  static Future<void> performGoogleSignIn(BuildContext context) async {
    // Google Sign-In is currently disabled.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Sign-In is currently disabled.')),
    );

    /*
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return;
      final GoogleSignInAuthentication googleAuth = await account.authentication;
      final String? idToken = googleAuth.idToken;
      if (idToken == null) throw Exception("Failed to get Google ID token");

      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      }

      final response = await ApiService.loginWithGoogle(idToken);
      if (!context.mounted) return;
      Navigator.pop(context);

      if (response["status"] != "error" && response["access_token"] != null) {
        final token = response["access_token"];
        final user = response["user"];
        final rawEmail = user != null ? (user["email"] ?? "") : (response["email"] ?? "");
        final resolvedEmail = (rawEmail is String && rawEmail.isNotEmpty) ? rawEmail : account.email;
        final rawUsername = user != null ? (user["username"] ?? "") : (response["username"] ?? "");
        final resolvedUsername = (rawUsername is String && rawUsername.isNotEmpty)
            ? rawUsername
            : resolvedEmail.split('@')[0];
        final rawName = user != null ? (user["name"] ?? user["fullName"] ?? "") : (response["name"] ?? response["fullName"] ?? "");
        final resolvedFullName = (rawName is String && rawName.isNotEmpty)
            ? rawName
            : (account.displayName ?? resolvedUsername);

        await UserSession.saveUser(
          username: resolvedUsername,
          email: resolvedEmail,
          fullName: resolvedFullName,
          token: token,
        );

        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/login_home');
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In Error: $error')),
        );
      }
    }
    */
  }
}
