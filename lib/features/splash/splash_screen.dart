// import 'package:flutter/material.dart';
// import '../onboarding/onboarding_screen_1.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const OnboardingScreen1()),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final logoSize = size.width * 0.38; // ~38% of screen width
//     final circleSize = logoSize * 1.3; // circle slightly larger than logo

//     // Wrapped in a Scaffold so the full-screen structure behaves correctly
//     // on a real device without overflowing or black screens.
//     return Scaffold(
//       backgroundColor: const Color(0xFF358C3A),
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Background circle
//             Container(
//               width: circleSize,
//               height: circleSize,
//               decoration: const ShapeDecoration(
//                 color: Color(0xFFD9D9D9),
//                 shape: OvalBorder(),
//               ),
//             ),
//             // Logo
//             Container(
//               width: logoSize,
//               height: logoSize,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/logo.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
