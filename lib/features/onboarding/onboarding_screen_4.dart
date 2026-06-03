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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final titleFontSize = (isPortrait ? size.width * 0.09 : size.height * 0.09).clamp(24.0, 38.0);
    final descFontSize = (isPortrait ? size.width * 0.04 : size.height * 0.04).clamp(13.0, 18.0);
    final imageHeight = isPortrait ? size.height * 0.23 : 70.0;
    final contentGap = isPortrait ? size.height * 0.10 : 16.0;

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
                child: isPortrait
                    ? Column(
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

                          SizedBox(height: contentGap),

                          // Screen 4 illustration
                          Image.asset(
                            'assets/onboarding_screen/onbod4.png',
                            height: imageHeight,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(height: contentGap),

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
                      )
                    : Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 12.0),
                              // Screen 4 title
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

                              SizedBox(height: contentGap),

                              // Screen 4 illustration
                              Image.asset(
                                'assets/onboarding_screen/onbod4.png',
                                height: imageHeight,
                                fit: BoxFit.contain,
                              ),

                              SizedBox(height: contentGap),

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
                              const SizedBox(height: 12.0),
                            ],
                          ),
                        ),
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
