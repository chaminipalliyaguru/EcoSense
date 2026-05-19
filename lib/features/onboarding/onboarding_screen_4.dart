import 'package:flutter/material.dart';
import 'onboarding_screen_5.dart';

// Reusable common widgets
import 'widgets/skip_button.dart';
import 'widgets/page_indicator.dart';
import 'widgets/onboarding_button.dart';

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleFontSize = (size.width * 0.09).clamp(28.0, 38.0);
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
            const SkipButton(),

            // Page-specific content area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Column(
                  children: [
                    const Spacer(),
                    // Screen 4 title: "Emission Analysis"
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Emission\n',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF343232),
                              height: 1.25,
                            ),
                          ),
                          TextSpan(
                            text: 'Analysis',
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

                    // Screen 4 illustration
                    Image.asset(
                      'assets/onboarding_screen/onbod4.png',
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: size.height * 0.10),

                    // Screen 4 description
                    SizedBox(
                      width: size.width * 0.78,
                      child: Text(
                        'Our intelligent model analyzes the\ndata and predicts results.',
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

            // Common Widget: Page indicator dots (page 4 of 5, index 3)
            const PageIndicator(currentPage: 3),

            // Common Widget: Action button → navigates to Screen 5
            OnboardingButton(
              label: 'Next',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen5()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
