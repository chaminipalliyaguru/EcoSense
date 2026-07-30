import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/user_session.dart';

class PredictionService {
  static const String _baseUrl = "https://model.synro.dev";

  static Future<Map<String, dynamic>> predict({
    required Map<String, dynamic> apiData,
    required List<double> smoke,
    required List<int> rpm,
    required List<double> acc,
  }) async {

    final body = {
      "records": [
        {
          "VehRegNo": apiData["reg_no"],
          "TestDateTime": apiData["date_of_issue"],

          "VehClass": apiData["vehicle_class"],
          "VehManuYear":
          int.tryParse(apiData["year_manufacture"].toString()),

          "K1Value": smoke[0],
          "K2Value": smoke[1],
          "K3Value": smoke[2],

          "RPM1": rpm[0],
          "RPM2": rpm[1],
          "RPM3": rpm[2],

          "TB1": acc[0],
          "TB2": acc[1],
          "TB3": acc[2],
        }
      ],

      "backend": "lightgbm",
      "explain": true,
      "include_ai_explanation": true
    };

    final token = await UserSession.getToken();
    final response = await http.post(
      Uri.parse("$_baseUrl/predict"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(response.body);
  }
}