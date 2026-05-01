import 'package:flutter/material.dart';

class GuestUserScreen extends StatelessWidget {
  const GuestUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/app_details_page_image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.4, 1.0],
                colors: [
                  Color(0x88289C3B), // dark green with opacity
                  Color(0x66289C3B), // medium green
                  Color(0x00FFFFFF), // transparent
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flexible spacer to push text down a bit (approx 1/4th of screen)
                  const Spacer(flex: 2),

                  // Title Text
                  const Text(
                    "Start Your Emission\nCheck Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Text
                  const Text(
                    "Explore the app to quickly upload your emission test report and view basic analysis results without creating an account. You can experience the main features before deciding to register for full access.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),

                  // Spacer to push button to the bottom
                  const Spacer(flex: 5),

                  // View App Details Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for View App Details
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3D7A44), // Match the dark green button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "View App Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
