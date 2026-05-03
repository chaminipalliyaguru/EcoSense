import 'package:flutter/material.dart';
import '../home/widgets/top_app_bar.dart';
import '../home/widgets/greeting_header.dart';
import '../home/widgets/home_hero_section.dart';
import '../home/widgets/scan_emission_card.dart';
import '../home/widgets/quick_tips_section.dart';
import '../Scan_upload_Report/scan_report_screen.dart';
import 'guest_bottom_nav_bar.dart';
import 'guest_feature_list.dart';

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
      backgroundColor: Colors.white,
      appBar: TopAppBar(primaryGreen: _primaryGreen),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeader(
              userName: '',
              subtitle: 'Smart care for your vehicle',
            ),
            const HomeHeroSection(),
            const SizedBox(height: 12),
            ScanEmissionCard(primaryGreen: _primaryGreen),
            const SizedBox(height: 24),
            const GuestFeatureList(),
            const SizedBox(height: 32),
            QuickTipsSection(primaryGreen: _primaryGreen),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: GuestBottomNavBar(
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
