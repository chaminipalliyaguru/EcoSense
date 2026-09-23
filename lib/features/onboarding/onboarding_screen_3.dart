import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onboarding_screen_4.dart';
import '../splash/welcome_screen.dart';
import '../../data/user_session.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FBF8),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity!.abs() > 100) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen4(),
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
                        color: const Color(0xFF527D5B),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // Central Illustration
              Center(
                child: Image.asset(
                  'assets/onboarding_screen/Onboarding-Screen3v2.png',
                  height: 298.h,
                  width: 298.w,
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(flex: 2),

              // Title & Subtitle Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 91.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Detailed Analysis',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF000000),
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Get instant insights on your\nemission levels with clear\nresults and recomondations.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF555555),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // Bottom Action Area (Back on left, Circular Next Arrow on right)
              Padding(
                padding: EdgeInsets.only(left: 36.w, right: 30.w, bottom: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF527D5B),
                        ),
                      ),
                    ),

                    // Next button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen4(),
                          ),
                        );
                      },
                      child: Container(
                        width: 82.84.w,
                        height: 82.84.w,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
