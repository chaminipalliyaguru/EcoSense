import 'package:flutter/material.dart';

/// A row of dots indicating the current page in the onboarding flow.
///
/// The active page is shown as a wider green bar, while inactive pages
/// are small grey circles. Includes smooth animation when switching pages.
///
/// [totalPages] - Total number of onboarding pages (default: 5).
/// [currentPage] - Zero-based index of the currently active page.
///
/// Usage:
/// ```dart
/// PageIndicator(currentPage: 0, totalPages: 5)
/// ```
class PageIndicator extends StatelessWidget {
  /// Zero-based index of the currently active page.
  final int currentPage;

  /// Total number of pages in the onboarding flow.
  final int totalPages;

  const PageIndicator({
    super.key,
    required this.currentPage,
    this.totalPages = 5,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final activeWidth = size.width * 0.08; // ~32 on 402-wide screen
    final inactiveWidth = size.width * 0.02; // ~8 on 402-wide screen
    final dotHeight = size.height * 0.007; // ~6 on 874-tall screen
    final spacing = size.width * 0.01;
    final bottomPad = size.height * 0.027;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPad),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: spacing),
            width: currentPage == index ? activeWidth : inactiveWidth,
            height: dotHeight.clamp(4.0, 8.0),
            decoration: BoxDecoration(
              color: currentPage == index
                  ? const Color(0xFF086B0C)
                  : const Color(0xFFBFCAB8),
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
        ),
      ),
    );
  }
}
