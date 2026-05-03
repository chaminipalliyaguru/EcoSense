import 'package:flutter/material.dart';
import '../guestuser/guest_user_home_page.dart';

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

              _buildFeatureListItem(
                title: "Emission Prediction",
                description:
                "Predicts emission levels based on the test report and vehicle data.",
                imagePath: "assets/images/appDetailed/emission prediction.png",
                bgColor: const Color(0xFFF1F8EE), // Light green
              ),

              _buildFeatureListItem(
                title: "Data Input for Vehicle Details",
                description: "Add and manage your vehicle information easily",
                imagePath: "assets/images/appDetailed/data-input.png",
                bgColor: const Color(0xFFE9F2FB), // Light blue
              ),

              _buildFeatureListItem(
                title: "Report Generation",
                description:
                "Get clear insights and manage suggestions based in analysis",
                imagePath: "assets/images/appDetailed/repot_ge.png",
                bgColor: const Color(0xFFF3E8FA), // Light purple
              ),

              _buildFeatureListItem(
                title: "Dashboard Visualization",
                description: "View trends and history with easy dashboards",
                imagePath: "assets/images/appDetailed/dashboard.png",
                bgColor: const Color(0xFFFFF3E6), // Light orange
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
              _buildSystemStepItem(
                stepNumber: "1",
                title: "User takes photo of emission testing reports",
                description: "Capture the report using the in-app camera.",
              ),

              // Step 2
              _buildSystemStepItem(
                stepNumber: "2",
                title: "System processes data",
                description:
                "The system app scans and extracts the required information.",
              ),

              // Step 3
              _buildSystemStepItem(
                stepNumber: "3",
                title: "Model predicts emission levels",
                description:
                "Our intelligent model analyzes the data and predicts results.",
              ),

              // Step 4
              _buildSystemStepItem(
                stepNumber: "4",
                title: "Results are displayed",
                description:
                "You get results along with reasons and recommendations",
                isLast: true,
              ),

              const SizedBox(height: 40),

              // Explore App Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GuestUserHomePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Explore App",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
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