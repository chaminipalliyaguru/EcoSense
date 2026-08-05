import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ReportValidator {
  static Future<ValidationResult> validate(File imageFile) async {
    int score = 0;
    List<String> foundItems = [];

    // -----------------------------
    // STEP 1 - Image quality check
    // -----------------------------
    final imageSize = await imageFile.length();

    if (imageSize > 100000) {
      score += 10;
      foundItems.add("Good image size");
    }

    // -----------------------------
    // STEP 2 - OCR
    // -----------------------------
    final inputImage = InputImage.fromFile(imageFile);

    final textRecognizer = TextRecognizer();

    final recognizedText =
    await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    final text = recognizedText.text.toLowerCase();

    // -----------------------------
    // STEP 3 - Keyword checks
    // -----------------------------

    if (text.contains("emission")) {
      score += 15;
      foundItems.add("Emission");
    }

    if (text.contains("certificate")) {
      score += 15;
      foundItems.add("Certificate");
    }

    if (text.contains("rpm")) {
      score += 15;
      foundItems.add("RPM");
    }

    if (text.contains("smoke")) {
      score += 15;
      foundItems.add("Smoke");
    }

    if (text.contains("density")) {
      score += 10;
      foundItems.add("Density");
    }

    if (text.contains("snap")) {
      score += 10;
      foundItems.add("Snap Data");
    }

    // -----------------------------
    // STEP 4 - Date detection
    // -----------------------------

    bool hasDate = RegExp(
      r'\d{2}[-/]\d{2}[-/]\d{4}',
    ).hasMatch(text);

    if (hasDate) {
      score += 10;
      foundItems.add("Date");
    }

    // -----------------------------
    // STEP 5 - Vehicle number
    // Examples:
    // WP CAB 1234
    // CAA-1234
    // ABC1234
    // -----------------------------

    bool hasVehicleNumber = RegExp(
      r'[a-z]{2,4}[- ]?\d{3,5}',
      caseSensitive: false,
    ).hasMatch(text);

    if (hasVehicleNumber) {
      score += 10;
      foundItems.add("Vehicle Number");
    }

    // -----------------------------
    // STEP 6 - RPM values
    // -----------------------------

    bool hasRPMValue = RegExp(
      r'\b[1-9]\d{3}\b',
    ).hasMatch(text);

    if (hasRPMValue) {
      score += 10;
      foundItems.add("RPM Values");
    }

    // -----------------------------
    // FINAL RESULT
    // -----------------------------

    return ValidationResult(
      isValid: score >= 70,
      score: score,
      extractedText: recognizedText.text,
      foundItems: foundItems,
    );
  }
}

class ValidationResult {
  final bool isValid;
  final int score;
  final String extractedText;
  final List<String> foundItems;

  ValidationResult({
    required this.isValid,
    required this.score,
    required this.extractedText,
    required this.foundItems,
  });
}