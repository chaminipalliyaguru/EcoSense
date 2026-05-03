import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/top_app_bar.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/greeting_header.dart';
import 'widgets/home_hero_section.dart';
import 'widgets/scan_emission_card.dart';
import 'widgets/feature_grid.dart';
import 'widgets/quick_tips_section.dart';
import '../Scan_upload_Report/scan_report_screen.dart';

class HomeScreenSignupLogin extends StatefulWidget {
  const HomeScreenSignupLogin({super.key});

  @override
  State<HomeScreenSignupLogin> createState() => _HomeScreenSignupLoginState();
}

class _HomeScreenSignupLoginState extends State<HomeScreenSignupLogin> {
  int _selectedIndex = 0;
  final Color _primaryGreen = const Color(0xFF3A7D44);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: TopAppBar(primaryGreen: _primaryGreen),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeader(userName: 'Username'),
            const HomeHeroSection(),
            ScanEmissionCard(primaryGreen: _primaryGreen),
            SizedBox(height: 20.h),
            const FeatureGrid(),
            SizedBox(height: 24.h),
            QuickTipsSection(primaryGreen: _primaryGreen),
            SizedBox(height: 32.h),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _navigateTo,
        primaryGreen: _primaryGreen,
      ),
    );
  }

  void _navigateTo(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ScanReportScreen()),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 2:
        break;
      case 3:
        break;
      default:
        break;
    }
  }
}
