import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/onboarding/onboarding_screen_1.dart';
import 'features/guestuser/guest_user_home_page.dart';
import 'features/home/home_screen_signup_login.dart';
import 'features/tips/tips_guide_screen.dart';
import 'features/userinfo/user_info_screen.dart';
import 'features/userinfo/edit_profile_screen.dart';
import 'features/verify_email/verify_email_screen.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

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
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF3A7D44)),
            useMaterial3: true,
          ),
          home: const WelcomeScreen(),
          routes: {
            '/home': (context) => const GuestUserHomePage(),
            '/login_home': (context) => const HomeScreenSignupLogin(),
            '/tips': (context) => const TipsGuideScreen(),
            '/profile': (context) => const UserInfoScreen(),
            '/edit_profile': (context) => const EditProfileScreen(),
            '/verify_email': (context) {
              final args = ModalRoute.of(context)?.settings.arguments as bool?;
              return VerifyEmailScreen(isPasswordReset: args ?? false);
            },
          },
        );
      },
    );
  }
}

