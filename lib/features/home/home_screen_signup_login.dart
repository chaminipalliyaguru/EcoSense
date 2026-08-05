import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/top_app_bar.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/greeting_header.dart';
import 'widgets/home_hero_section.dart';
import 'widgets/scan_emission_card.dart';
import 'widgets/feature_grid.dart';
import '../Scan_upload_Report/scan_report_screen.dart';
import '../history/history_screen.dart';
import '../../data/user_session.dart';

class HomeScreenSignupLogin extends StatefulWidget {
  const HomeScreenSignupLogin({super.key});

  @override
  State<HomeScreenSignupLogin> createState() => _HomeScreenSignupLoginState();
}

class _HomeScreenSignupLoginState extends State<HomeScreenSignupLogin> {
  int _selectedIndex = 0;
  final Color _primaryGreen = const Color(0xFF3A7D44);
  String _displayName = "";
  int _avatarIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userData = await UserSession.getUser();
    setState(() {
      _displayName = userData['full_name'] ?? "";
      if (_displayName.isEmpty) {
        _displayName = userData['username'] ?? "";
      }
      _avatarIndex = userData['avatar_index'] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: TopAppBar(primaryGreen: _primaryGreen),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreetingHeader(
                  name: _displayName,
                  avatarIndex: _avatarIndex,
                ),
                const HomeHeroSection(),
                ScanEmissionCard(primaryGreen: _primaryGreen),
                SizedBox(height: 20.h),
                const FeatureGrid(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
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

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HistoryScreen(isGuest: false)),
      ).then((_) {
        _loadUserName();
      });
      return;
    }

    if (index == 3) {
      Navigator.pushNamed(context, '/profile').then((_) {
        _loadUserName();
      });
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
}
