import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../data/user_session.dart';

class ApiService {
  // Toggle to switch between local development and production backends.
  // When using localhost on Android Emulator, it will map to 10.0.2.2.
  static const bool _useLocalBackend = false;
  //static const bool _useLocalBackend = true;

  static String get baseUrl {
    if (_useLocalBackend) {
      if (!kIsWeb && Platform.isAndroid) {
        return "http://10.0.2.2:8000";
      }
      return "http://localhost:8000";
    }
    return "https://api.synro.dev";
  }

  static String get ocrBaseUrl {
    if (_useLocalBackend) {
      if (!kIsWeb && Platform.isAndroid) {
        return "http://10.0.2.2:8000";
      }
      return "http://localhost:8000";
    }
    return "https://ocr.synro.dev";
  }

  // Safe helper to process HTTP response
  static Map<String, dynamic> _processResponse(http.Response response, String defaultErrorMsg) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          return body;
        } else {
          return {
            "status": "error",
            "message": body["detail"] ?? body["message"] ?? "$defaultErrorMsg (${response.statusCode})"
          };
        }
      }
    } catch (e) {
      // Body is not JSON (e.g. HTML from 502/404) or failed to parse
      print("JSON Parsing/Decode Error: $e, Body: ${response.body}");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        "status": "success",
        "message": "Operation completed successfully"
      };
    }

    // Return a status-code based error if not JSON
    return {
      "status": "error",
      "message": "Server error (${response.statusCode}): ${response.reasonPhrase ?? 'Unknown Error'}"
    };
  }

  // Generic exception handler to provide precise error details
  static Map<String, dynamic> _handleError(Object error, String context) {
    print("$context ERROR: $error");
    
    if (error is SocketException) {
      return {
        "status": "error",
        "message": "Network error: Unable to connect to the server. Please check your internet connection."
      };
    } else if (error is HttpException) {
      return {
        "status": "error",
        "message": "HTTP error: Unable to reach the server. Please try again later."
      };
    } else if (error is FormatException) {
      return {
        "status": "error",
        "message": "Response format error: Received invalid response from the server."
      };
    } else {
      return {
        "status": "error",
        "message": "Unexpected error: ${error.toString()}"
      };
    }
  }

  static Future<Map<String, dynamic>> uploadReport(File image) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$ocrBaseUrl/extract"),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          image.path,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("OCR Status: ${response.statusCode}");
      print("OCR Response: ${response.body}");

      final processed = _processResponse(response, "OCR extraction failed");
      if (processed["status"] == "error") {
        throw Exception(processed["message"]);
      }
      return processed;
    } catch (e) {
      print("OCR ERROR: $e");
      rethrow;
    }
  }

  //Login API
  static Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "identifier": identifier,
          "password": password,
        }),
      );
      return _processResponse(response, "Login failed");
    } catch (e) {
      return _handleError(e, "LOGIN");
    }
  }

  //Sign Up
  static Future<Map<String, dynamic>> signup({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "username": username,
          "email": email,
          "password": password,
        }),
      );
      return _processResponse(response, "Signup failed");
    } catch (e) {
      return _handleError(e, "SIGNUP");
    }
  }

  static Future<Map<String, dynamic>> verifyOTP({
    required String otp,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-signup-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );
      return _processResponse(response, "Verification failed");
    } catch (e) {
      return _handleError(e, "VERIFY OTP");
    }
  }

  static Future<Map<String, dynamic>> verifyResetOTP({
    required String otp,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-reset-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );
      return _processResponse(response, "Verification failed");
    } catch (e) {
      return _handleError(e, "VERIFY RESET OTP");
    }
  }

  //Forgot Password
  static Future<Map<String, dynamic>> forgetPasswordEmail({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/forgot-password?email=$email'),
      );
      return _processResponse(response, "Failed to send OTP");
    } catch (e) {
      return _handleError(e, "FORGOT PASSWORD");
    }
  }

  //Take New Password
  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String new_password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "new_password": new_password,
        }),
      );
      return _processResponse(response, "Password Reset Failed");
    } catch (e) {
      return _handleError(e, "RESET");
    }
  }
  // --- User Profile Endpoints ---

  static Future<Map<String, String>> _getAuthHeaders() async {
    final token = await UserSession.getToken();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: headers,
      );
      return _processResponse(response, "Failed to get user details");
    } catch (e) {
      return _handleError(e, "GET USER DETAILS");
    }
  }

  static Future<Map<String, dynamic>> changeName(String name) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/users/name'),
        headers: headers,
        body: jsonEncode({"name": name}),
      );
      return _processResponse(response, "Failed to change name");
    } catch (e) {
      return _handleError(e, "CHANGE NAME");
    }
  }

  static Future<Map<String, dynamic>> changeUsername(String username) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/users/username'),
        headers: headers,
        body: jsonEncode({"username": username}),
      );
      return _processResponse(response, "Failed to change username");
    } catch (e) {
      return _handleError(e, "CHANGE USERNAME");
    }
  }

  static Future<Map<String, dynamic>> requestEmailChange(String newEmail) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/users/change-email/request'),
        headers: headers,
        body: jsonEncode({"new_email": newEmail}),
      );
      return _processResponse(response, "Failed to request email change");
    } catch (e) {
      return _handleError(e, "REQUEST EMAIL CHANGE");
    }
  }

  static Future<Map<String, dynamic>> verifyOldEmail(String otp) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/users/change-email/verify-old'),
        headers: headers,
        body: jsonEncode({"otp": otp}),
      );
      return _processResponse(response, "Failed to verify old email");
    } catch (e) {
      return _handleError(e, "VERIFY OLD EMAIL");
    }
  }

  static Future<Map<String, dynamic>> verifyNewEmail(String otp) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/users/change-email/verify-new'),
        headers: headers,
        body: jsonEncode({"otp": otp}),
      );
      return _processResponse(response, "Failed to verify new email");
    } catch (e) {
      return _handleError(e, "VERIFY NEW EMAIL");
    }
  }
}
