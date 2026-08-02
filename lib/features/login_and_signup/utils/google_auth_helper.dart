import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../data/user_session.dart';
import '../../../services/api_service.dart';
import '../widgets/auth_widgets.dart';

class GoogleAuthHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '425105073862-26c3u02977evqohntkvveeqri630kvrm.apps.googleusercontent.com',
  );

  static Future<void> performGoogleSignIn(BuildContext context) async {
    try {
      // Trigger the native device Google Account chooser
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      
      // If the user cancelled or closed the picker, stop the flow.
      if (account == null) return;

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await account.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception("Failed to get Google ID token");
      }

      // Show loading dialog while verifying with backend
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GoogleLogoWidget(size: 32),
                      SizedBox(height: 32),
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF4A7B59)),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Signing in with Google...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }

      // Verify token with backend
      final response = await ApiService.loginWithGoogle(idToken);

      if (!context.mounted) return;

      // Close loading dialog
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

        // Save real session data from backend
        await UserSession.saveUser(
          username: resolvedUsername,
          email: resolvedEmail,
          fullName: resolvedFullName,
          token: token,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Successfully signed in as ${resolvedFullName.isNotEmpty ? resolvedFullName : resolvedEmail}!'),
              backgroundColor: const Color(0xFF4A7B59),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Navigate to home screen
          Navigator.pushReplacementNamed(context, '/login_home');
        }
      } else {
        // Backend verification failed
        throw Exception(response["message"] ?? "Backend verification failed");
      }
    } catch (error) {
      final errorStr = error.toString();
      
      if (context.mounted) {
        // If error is ApiException 10 (DEVELOPER_ERROR)
        if (errorStr.contains("ApiException: 10") || errorStr.contains("DEVELOPER_ERROR")) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                title: const Row(
                  children: [
                    GoogleLogoWidget(size: 24),
                    SizedBox(width: 10),
                    Text("Google Sign-In Error"),
                  ],
                ),
                content: const Text(
                  "This error (ApiException 10) occurs because your local Android debug keystore's SHA-1 fingerprint is not registered in your Firebase Console.\n\n"
                  "Please add your SHA-1 signature under your Android app in your Firebase Project Settings, update google-services.json, and rebuild your app.",
                  style: TextStyle(fontSize: 14),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          // General errors
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Google Sign-In Error"),
                content: Text("Failed to sign in with Google:\n\n$error"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }
}
