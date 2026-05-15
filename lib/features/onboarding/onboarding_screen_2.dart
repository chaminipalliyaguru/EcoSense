import 'package:flutter/material.dart';
import 'onboarding_screen_3.dart';

// Reusable common widgets
import 'widgets/skip_button.dart';
import 'widgets/page_indicator.dart';
import 'widgets/onboarding_button.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleFontSize = (size.width * 0.07).clamp(22.0, 32.0);
    final descFontSize = (size.width * 0.04).clamp(13.0, 18.0);
    final imageHeight = size.height * 0.23;
    final titleImageGap = size.height * 0.027;
    final imageDescGap = size.height * 0.046;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: SafeArea(
        child: Column(
          children: [
            // Common Widget: Skip button (top-right green pill)
            SkipButton(onTap: () {
              // TODO: Navigate to main app / login
            }),

            // Page-specific content area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Screen 2 title: "Upload Your Report"
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Upload Your\n',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF343232),
                              height: 1.25,
                            ),
                          ),
                          TextSpan(
                            text: 'Report',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF527D5B),
                              height: 1.25,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: titleImageGap),

                    // Screen 2 illustration
                    Image.asset(
                      'assets/onboarding_screen/onbod2.png',
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: imageDescGap),

                    // Screen 2 description
                    SizedBox(
                      width: size.width * 0.78,
                      child: Text(
                        'Take a clear photo of the emission\nreport using your camera.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: descFontSize,
                          color: const Color(0xFF979797),
                          fontWeight: FontWeight.w400,
                          height: 1.58,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Common Widget: Page indicator dots (page 2 of 5, index 1)
            const PageIndicator(currentPage: 1),

            // Common Widget: Action button → navigates to Screen 3
            OnboardingButton(
              label: 'Next',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen3()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
