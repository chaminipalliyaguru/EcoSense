import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onboarding_screen_2.dart';
import '../splash/welcome_screen.dart';
import '../../data/user_session.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/onboarding_screen/onboardBg1v2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content Layer
          SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null &&
                    details.primaryVelocity!.abs() > 100) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen2(),
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  // Top Row with Skip button
                  Padding(
                    padding: EdgeInsets.only(top: 48.h, right: 39.w),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () async {
                          await UserSession.setSeenOnboarding();
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomeScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF508E65),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // EcoSense Logo
                  Center(
                    child: Image.asset(
                      'assets/logov2.png',
                      width: 192.w,
                      height: 142.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Title & Subtitle Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'A Cleaner Tomorrow\nStarts Today',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF000000),
                            height: 1.25,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Check, understand and reduce\nemissions for a healthier\nenvironment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF333333),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Bottom Action Button (Circular Next Arrow)
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OnboardingScreen2(),
                            ),
                          );
                        },
                        child: Container(
                          width: 82.844.w,
                          height: 82.844.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF237340),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 32.sp,
                          ),
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
