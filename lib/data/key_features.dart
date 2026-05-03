import 'package:flutter/material.dart';

class Feature {
  final String title;
  final String description;
  final String imagePath;
  final Color bgColor;

  Feature({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.bgColor,
  });
}

final List<Feature> appFeatures = [
  Feature(
    title: "Emission Prediction",
    description:
    "Predicts emission levels based on the test report and vehicle data.",
    imagePath: "assets/images/appDetailed/emission prediction.png",
    bgColor: Color(0xFFF1F8EE),
  ),
  Feature(
    title: "Data Input for Vehicle Details",
    description: "Add and manage your vehicle information easily",
    imagePath: "assets/images/appDetailed/data-input.png",
    bgColor: Color(0xFFE9F2FB),
  ),
  Feature(
    title: "Report Generation",
    description:
    "Get clear insights and manage suggestions based in analysis",
    imagePath: "assets/images/appDetailed/repot_ge.png",
    bgColor: Color(0xFFF3E8FA),
  ),
  Feature(
    title: "Dashboard Visualization",
    description: "View trends and history with easy dashboards",
    imagePath: "assets/images/appDetailed/dashboard.png",
    bgColor: Color(0xFFFFF3E6),
  ),
];