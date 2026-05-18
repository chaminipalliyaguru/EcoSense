import 'package:flutter/material.dart';
import 'onboarding_screen_4.dart';

// Reusable common widgets
import 'widgets/skip_button.dart';
import 'widgets/page_indicator.dart';
import 'widgets/onboarding_button.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

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
                  children: [
                    const Spacer(),
                    // Screen 3 title: "System Processes Data"
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'System\n',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF343232),
                              height: 1.25,
                            ),
                          ),
                          TextSpan(
                            text: 'Processes Data',
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

                    SizedBox(height: size.height * 0.10),

                    // Screen 3 illustration
                    Image.asset(
                      'assets/onboarding_screen/onbod3.png',
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: size.height * 0.10),

                    // Screen 3 description
                    SizedBox(
                      width: size.width * 0.78,
                      child: Text(
                        'The system app scans and extracts the\nrequired information.',
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
                    const Spacer(),
                  ],
                ),
              ),
            ),

            // Common Widget: Page indicator dots (page 3 of 5, index 2)
            const PageIndicator(currentPage: 2),

            // Common Widget: Action button → navigates to Screen 4
            OnboardingButton(
              label: 'Next',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen4()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
