import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://172.17.68.236:8000";

  static Future<http.StreamedResponse> uploadReport(File image) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/extract"),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        image.path,
      ),
    );

    return await request.send();
  }
}