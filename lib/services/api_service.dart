import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String OCRbaseUrl = "https://ocr.synro.dev/docs";
  static const String baseUrl =
      "http://10.28.177.46:8000"; //IPv4 Address of Wireless LAN adapter Wi-Fi

  static Future<http.StreamedResponse> uploadReport(File image) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$OCRbaseUrl/extract"),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        image.path,
      ),
    );

    return await request.send();
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

      return jsonDecode(response.body);
    } catch (e) {
      return {
        "status": "error",
        "message": "Unable to connect to server",
      };
    }
  }

  //Verify OTP
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
      return jsonDecode(response.body);
    } catch (e) {
      return {
        "status": "error",
        "message": "Unable to connect to server",
      };
    }
  }

  //Reset Password
  // static Future<Map<String, dynamic>> resetPassword({
  //   required String password,
  //   required String email,
  // }) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/auth/verify-signup-otp'),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "email": email,
  //         "new_password": password,
  //       }),
  //     );
  //     return jsonDecode(response.body);
  //   } catch (e) {
  //     return {
  //       "status": "error",
  //       "message": "Unable to connect to server",
  //     };
  //   }
  // }

  //Forgot Password
  static Future<Map<String, dynamic>> forgetPasswordEmail({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-signup-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
        }),
      );
      return jsonDecode(response.body);
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
        Uri.parse('$baseUrl/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "new_password": new_password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "status": "error",
          "message": jsonDecode(response.body)["detail"] ?? "Password Failed."
        };
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      return {"status": "error", "message": "Unable to connect to server"};
    }
  }
}
