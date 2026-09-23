import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../login_and_signup/login_screen.dart';
import '../login_and_signup/signup_screen.dart';
import '../guestuser/guest_user_home_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcomeBgv2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content Layer
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Top EcoSense Logo
                  Image.asset(
                    'assets/logov2.png',
                    width: 78.w,
                    height: 58.h,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 36.h),

                  // Welcome Heading
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000000),
                      height: 1.2,
                    ),
                  ),
                  Text(
                    'EcoSense',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF000000),
                      height: 1.1,
                    ),
                  ),

                  const Spacer(),

                  // Bottom Action Buttons Section
                  Padding(
                    padding: EdgeInsets.only(bottom: 35.h),
                    child: Column(
                      children: [
                        // Explore as Guest Button
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GuestUserHomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF237340),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(46.r),
                              ),
                            ),
                            child: Text(
                              'Explore as Guest',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 14.h),

                        // Sign up Button
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.85),
                              elevation: 0,
                              side: const BorderSide(
                                color: Color(0xFF237340),
                                width: 1.2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(46.r),
                              ),
                            ),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 14.h),

                        // Log in Button
                        SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFCBDDCB).withOpacity(0.85),
                              elevation: 0,
                              side: BorderSide(
                                color:
                                    const Color(0xFF527D5B).withOpacity(0.3),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(46.r),
                              ),
                            ),
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF000000),
                              ),
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
        ],
      ),
    );
  }
}
