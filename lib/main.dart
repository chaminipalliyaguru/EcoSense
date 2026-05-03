import 'package:flutter/material.dart';
import 'features/splash/welcome_screen.dart';
import 'features/home/home_screen_signup_login.dart';
// import './features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      routes: {
        '/home': (context) => const HomeScreenSignupLogin(),
      },
    );
  }
}

