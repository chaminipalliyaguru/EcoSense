import 'package:flutter/material.dart';

/// A green pill-shaped "Skip" button used at the top-right of onboarding screens.
/// Allows the user to skip the entire onboarding flow.
///
/// Usage:
/// ```dart
/// SkipButton(onTap: () { /* navigate to main app */ })
/// ```
class SkipButton extends StatelessWidget {
  /// Callback triggered when the user taps "Skip".
  final VoidCallback onTap;

  const SkipButton({super.key, required this.onTap});

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
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPad,
              vertical: verticalPad,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFC1FFB3),
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
