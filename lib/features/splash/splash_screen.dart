import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/user_session.dart';
import '../home/home_screen_signup_login.dart';
import '../onboarding/onboarding_screen_1.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppSession();
  }

  Future<void> _checkAppSession() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final token = await UserSession.getToken();
    final hasSeenOnboarding = await UserSession.hasSeenOnboarding();

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenSignupLogin()),
      );
    } else if (hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen1()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 180.w,
              height: 180.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 30.h),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3A7D44)),
            ),
          ],
        ),
      ),
    );
  }
}
