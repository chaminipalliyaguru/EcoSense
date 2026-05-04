import 'package:flutter/material.dart';
import '../guestuser/guest_user_home_page.dart';
import '../../widgets/feature_list_item.dart';
import '../../data/key_features.dart';
import '../../data/system_steps_data.dart';
import '../../widgets/system_step_item.dart';
import '../../widgets/button.dart';

class AppDetailsScreen extends StatelessWidget {
  const AppDetailsScreen({super.key});

  final Color _primaryGreen = const Color(0xFF4A7B59);


  Widget _buildFeatureListItem({
    required String title,
    required String description,
    required String imagePath,
    required Color bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Box
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // match the screenshot icon fit
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello ! Username",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "App Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _primaryGreen,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color:
                  const Color(0xFFA1BBA4), // Sage green matching screenshot
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "This application is for vehicle owners. After you have done emission testing, you can upload the report through camera. The app scans the report and gives the reason for failure (if failed) and also recommendations on how to fix it. It also provides recommendations to repair vehicle even for pass reports",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Key Features",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _primaryGreen,
                ),
              ),
              const SizedBox(height: 24),

              Column(
                children: appFeatures.map((feature) {
                  return FeatureListItem(
                    title: feature.title,
                    description: feature.description,
                    imagePath: feature.imagePath,
                    bgColor: feature.bgColor,
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              // How the System Works Section
              Text(
                "How the System Works",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _primaryGreen,
                ),
              ),
              const SizedBox(height: 30),

              // Step 1
              Column(
                children: List.generate(systemSteps.length, (index) {
                  final step = systemSteps[index];

                  return SystemStepItem(
                    stepNumber: step.stepNumber,
                    title: step.title,
                    description: step.description,
                    primaryGreen: _primaryGreen,
                    isLast: index == systemSteps.length - 1,
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Explore App Button
              Button(
                text: "Explore App",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GuestUserHomePage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemStepItem({
    required String stepNumber,
    required String title,
    required String description,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Number Circle with Vertical Line
          Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    stepNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 60,
                  color: _primaryGreen.withOpacity(0.3),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}