import 'package:flutter/material.dart';
import 'onboarding_screen_2.dart';

// Reusable common widgets
import 'widgets/skip_button.dart';
import 'widgets/page_indicator.dart';
import 'widgets/onboarding_button.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final titleFontSize = (isPortrait ? size.width * 0.1 : size.height * 0.1).clamp(24.0, 44.0);
    final descFontSize = (isPortrait ? size.width * 0.04 : size.height * 0.04).clamp(13.0, 18.0);
    final titleWidth = isPortrait ? size.width * 0.76 : size.width * 0.85; // ~305 on 402-wide
    final descWidth = isPortrait ? size.width * 0.78 : size.width * 0.85; // ~314 on 402-wide
    final titleDescGap = isPortrait ? size.height * 0.33 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: SafeArea(
        child: Column(
          children: [
            // Common Widget: Skip button (top-right green pill)
            const SkipButton(),

            // Page-specific content area
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const OnboardingScreen2()),
                  );
                },
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Screen 1 title: "Start Your Emission Check Now"
                        SizedBox(
                          width: titleWidth,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                  TextSpan(
                                    text: 'Start Your ',
                                    style: TextStyle(
                                      color: const Color(0xFF343232),
                                      fontSize: titleFontSize,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      height: 1.25,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Emission Check ',
                                    style: TextStyle(
                                      color: const Color(0xFF527D5B),
                                      fontSize: titleFontSize,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      height: 1.25,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Now🍃',
                                    style: TextStyle(
                                      color: const Color(0xFF343232),
                                      fontSize: titleFontSize,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      height: 1.25,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(height: titleDescGap),

                          // Screen 1 description
                          SizedBox(
                            width: descWidth,
                            child: Text(
                              'Explore the app to quickly upload your emission test report and view basic analysis results without creating an account. You can experience the main features before deciding to register for full access.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF979797),
                                fontSize: descFontSize,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 1.58,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Common Widget: Page indicator dots (page 1 of 5, index 0)
            const PageIndicator(currentPage: 0),

            // Common Widget: Action button → navigates to Screen 2
            OnboardingButton(
              label: 'Next',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
