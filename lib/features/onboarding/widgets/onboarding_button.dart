import 'package:flutter/material.dart';

/// A rounded green action button used at the bottom of onboarding screens.
///
/// Displays either "Next" (to go to the next page) or "Get Started"
/// (on the last page to enter the app).
///
/// [label] - The text to display on the button (e.g., "Next" or "Get Started").
/// [onPressed] - Callback triggered when the button is tapped.
///
/// Usage:
/// ```dart
/// OnboardingButton(
///   label: 'Next',
///   onPressed: () { /* navigate to next screen */ },
/// )
/// ```
class OnboardingButton extends StatelessWidget {
  /// The text displayed on the button.
  final String label;

  /// Callback triggered when the button is tapped.
  final VoidCallback onPressed;

  const OnboardingButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final btnWidth = size.width * 0.4; // ~162 on 402-wide screen
    final btnHeight = size.height * 0.057; // ~50 on 874-tall screen
    final fontSize = size.width * 0.04; // ~16 on 402-wide screen
    final bottomPad = size.height * 0.046;
    final radius = btnHeight * 0.66;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPad),
      child: SizedBox(
        width: btnWidth,
        height: btnHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF358C3A),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: fontSize.clamp(13.0, 18.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
