import 'package:flutter/material.dart';
import '../features/home/widgets/bottom_nav_bar.dart';
import '../features/guestuser/guest_bottom_nav_bar.dart';

class AppBottomNav extends StatelessWidget {
  final bool isGuest;
  final int selectedIndex;
  final Function(int) onTap;
  final Color primaryGreen;

  const AppBottomNav({
    super.key,
    required this.isGuest,
    required this.selectedIndex,
    required this.onTap,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    if (isGuest) {
      return GuestBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onTap,
        primaryGreen: primaryGreen,
      );
    } else {
      return BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onTap,
        primaryGreen: primaryGreen,
      );
    }
  }
}