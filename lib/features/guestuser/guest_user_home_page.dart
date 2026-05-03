import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../home/widgets/top_app_bar.dart';
import '../home/widgets/bottom_nav_bar.dart';
import '../home/widgets/greeting_header.dart';
import '../home/widgets/home_hero_section.dart';
import '../home/widgets/scan_emission_card.dart';
import '../home/widgets/feature_grid.dart';
import '../home/widgets/quick_tips_section.dart';
import '../Scan_upload_Report/scan_report_screen.dart';

class GuestUserHomePage extends StatefulWidget {
  const GuestUserHomePage({super.key});

  @override
  State<GuestUserHomePage> createState() => _GuestUserHomePageState();
}

class _GuestUserHomePageState extends State<GuestUserHomePage> {
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
            const GreetingHeader(userName: 'Guest'), // Guest user
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
  }
}