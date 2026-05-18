import 'package:flutter/material.dart';
import '../splash/welcome_screen.dart';

// Reusable common widgets
import 'widgets/skip_button.dart';
import 'widgets/page_indicator.dart';
import 'widgets/onboarding_button.dart';

class OnboardingScreen5 extends StatelessWidget {
  const OnboardingScreen5({super.key});

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            }),

            // Page-specific content area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Column(
                  children: [
                    const Spacer(),
                    // Screen 5 title: "View Results & Recommendations"
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'View Results &\n',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF343232),
                              height: 1.25,
                            ),
                          ),
                          TextSpan(
                            text: 'Recommendations',
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

                    // Screen 5 illustration
                    Image.asset(
                      'assets/onboarding_screen/onbod5.png',
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: size.height * 0.10),

                    // Screen 5 description
                    SizedBox(
                      width: size.width * 0.78,
                      child: Text(
                        'You get results along with\nreasons and recommendations',
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

            // Common Widget: Page indicator dots (page 5 of 5, index 4)
            const PageIndicator(currentPage: 4),

            // Common Widget: Action button → "Get Started" (last page)
            OnboardingButton(
              label: 'Get Started',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
