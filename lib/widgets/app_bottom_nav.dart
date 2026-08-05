import 'package:flutter/material.dart';
import '../features/home/widgets/bottom_nav_bar.dart';
import '../features/guestuser/guest_bottom_nav_bar.dart';
import '../features/guestuser/guest_user_home_page.dart';
import '../features/home/home_screen_signup_login.dart';
import '../features/Scan_upload_Report/scan_report_screen.dart';
import '../features/history/history_screen.dart';
import '../features/userinfo/user_info_screen.dart';

class AppBottomNav extends StatelessWidget {
  final bool isGuest;
  final int selectedIndex;
  final Function(int)? onTap;
  final Color primaryGreen;

  const AppBottomNav({
    super.key,
    required this.isGuest,
    required this.selectedIndex,
    this.onTap,
    required this.primaryGreen,
  });

  void _defaultOnTap(BuildContext context, int index) {
    if (index == 0) {
      final isAlreadyHome = context.findAncestorWidgetOfExactType<HomeScreenSignupLogin>() != null ||
                            context.findAncestorWidgetOfExactType<GuestUserHomePage>() != null;
      if (isAlreadyHome) return;

      if (isGuest) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const GuestUserHomePage()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenSignupLogin()),
          (route) => false,
        );
      }
      return;
    }

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ScanReportScreen()),
      );
      return;
    }

    if (index == 2 && !isGuest) {
      final isAlreadyHistory = context.findAncestorWidgetOfExactType<HistoryScreen>() != null;
      if (isAlreadyHistory) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HistoryScreen(isGuest: false)),
      );
      return;
    }

    if (index == 3 && !isGuest) {
      final isAlreadyProfile = context.findAncestorWidgetOfExactType<UserInfoScreen>() != null;
      if (isAlreadyProfile) return;

      Navigator.pushNamed(context, '/profile');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeOnTap = onTap ?? (index) => _defaultOnTap(context, index);

    if (isGuest) {
      return GuestBottomNavBar(
        selectedIndex: selectedIndex < 2 ? selectedIndex : 0,
        onTap: activeOnTap,
        primaryGreen: primaryGreen,
      );
    } else {
      return BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: activeOnTap,
        primaryGreen: primaryGreen,
      );
    }
  }
}