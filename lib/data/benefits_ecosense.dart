import 'package:flutter/material.dart';

class Benefits {
  final String title;
  final String description;
  final String imagePath;
  final Color bgColor;

  Benefits({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.bgColor,
  });
}

final List<Benefits> appBenefits = [
  Benefits(
      title: "Helps Reduce Pollution",
      description:
          "Encourages proper vehicle maintenance and reduces harmful emissions",
      imagePath: "assets/images/appBenefits/reduce-pollution.png",
      bgColor: Colors.white),
  Benefits(
      title: "Supports Decision Making",
      description:
          "Provides clear insights and recommendations for better repair decisions",
      imagePath: "assets/images/appBenefits/decision-making.png",
      bgColor: Colors.white),
  Benefits(
      title: "Saves Time",
      description:
          "Quick report analysis and smart recommendations saves time and effort",
      imagePath: "assets/images/appBenefits/save-time.png",
      bgColor: Colors.white),
];
