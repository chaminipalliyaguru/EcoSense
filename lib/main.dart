import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/splash/welcome_screen.dart';
import 'features/home/home_screen_signup_login.dart';
import 'features/guestuser/guest_user_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EcoSense',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3A7D44)),
            useMaterial3: true,
          ),
          home: const WelcomeScreen(),
          routes: {
            '/home': (context) => const GuestUserHomePage(),
            '/login_home': (context) => const HomeScreenSignupLogin(),
          },
        );
      },
    );
  }
}

