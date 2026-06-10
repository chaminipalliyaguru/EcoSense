import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/onboarding/onboarding_screen_1.dart';
import 'features/guestuser/guest_user_home_page.dart';
import 'features/home/home_screen_signup_login.dart';
import 'features/tips/tips_guide_screen.dart';
import 'features/userinfo/user_info_screen.dart';
import 'features/userinfo/edit_profile_screen.dart';
import 'features/verify_email/verify_email_screen.dart';
import 'features/splash/welcome_screen.dart';
import 'features/splash/splash_screen.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
            snackBarTheme: SnackBarThemeData(
              backgroundColor: Colors.white,
              elevation: 4,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              contentTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const GuestUserHomePage(),
            '/login_home': (context) => const HomeScreenSignupLogin(),
            '/tips': (context) => const TipsGuideScreen(),
            '/profile': (context) => const UserInfoScreen(),
            '/edit_profile': (context) => const EditProfileScreen(),
            // '/verify_email': (context) {
            //   final args = ModalRoute.of(context)?.settings.arguments as bool?;
            //   return VerifyEmailScreen(isPasswordReset: args ?? false);
            // },
          },
        );
      },
    );
  }
}

