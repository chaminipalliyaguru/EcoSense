import 'package:flutter/material.dart';
import '../../splash/welcome_screen.dart';

/// A green pill-shaped "Skip" button used at the top-right of onboarding screens.
/// Allows the user to skip the entire onboarding flow.
///
/// Usage:
/// ```dart
/// SkipButton() // automatically navigates to WelcomeScreen
/// ```
class SkipButton extends StatelessWidget {
  /// Optional custom callback. If not provided, it defaults to navigating to [WelcomeScreen].
  final VoidCallback? onTap;

  const SkipButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.04; // ~16 on 402-wide screen
    final horizontalPad = size.width * 0.05;
    final verticalPad = size.height * 0.009;
    final topPad = size.height * 0.014;
    final rightPad = size.width * 0.057;

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: topPad, right: rightPad),
        child: GestureDetector(
          onTap: onTap ?? () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPad,
              vertical: verticalPad,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD9FFD1),
              borderRadius: BorderRadius.circular(29),
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: fontSize.clamp(12.0, 18.0),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF358C3A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
