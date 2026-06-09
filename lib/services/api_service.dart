import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.synro.dev";
  static const String ocrBaseUrl = "https://ocr.synro.dev";

  static Future<Map<String, dynamic>> uploadReport(File image) async {
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

    final response = await request.send();

    final responseBody = await response.stream.bytesToString();

    print("OCR Status: ${response.statusCode}");
    print("OCR Response: $responseBody");

    return jsonDecode(responseBody);
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

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "status": "error",
          "message": jsonDecode(response.body)["detail"] ?? "Login failed"
        };
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      return {"status": "error", "message": "Unable to connect to server"};
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

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "status": "error",
          "message": jsonDecode(response.body)["detail"] ?? "Signup failed"
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "Unable to connect to server",
      };
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
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "status": "error",
          "message": jsonDecode(response.body)["detail"] ?? "Verification failed"
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "Unable to connect to server",
      };
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
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "status": "error",
          "message": jsonDecode(response.body)["detail"] ?? "Verification failed"
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "Unable to connect to server",
      };
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
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        var body = jsonDecode(response.body);
        return {
          "status": "error",
          "message": body["detail"] ?? body["message"] ?? "Failed to send OTP"
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "Unable to connect to server",
      };
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

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        var body = jsonDecode(response.body);
        return {
          "status": "error",
          "message": body["detail"] ?? body["message"] ?? "Password Reset Failed."
        };
      }
    } catch (e) {
      print("RESET ERROR: $e");
      return {"status": "error", "message": "Unable to connect to server"};
    }
  }
}
