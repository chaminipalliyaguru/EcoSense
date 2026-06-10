import 'package:flutter/material.dart';
import '../../widgets/app_bottom_nav.dart';
import '../Scan_upload_Report/scan_report_screen.dart';
import '../history/history_screen.dart';
import 'widgets/result_status_indicator.dart';
import 'widgets/result_info_card.dart';
import 'widgets/view_details_button.dart';
import '../EditDetails/edit_details_screen.dart';
import '../../data/user_session.dart';
import '../guestuser/guest_user_home_page.dart';
import '../home/home_screen_signup_login.dart';

class FailReportScreen extends StatefulWidget {
  const FailReportScreen({super.key});

  @override
  State<FailReportScreen> createState() => _FailReportScreenState();
}

class _FailReportScreenState extends State<FailReportScreen> {
  int _selectedIndex = 1;
  final Color _primaryGreen = const Color(0xFF5A805E);
  bool _isGuest = false;

  @override
  void initState() {
    super.initState();
    _checkGuestStatus();
  }

  Future<void> _checkGuestStatus() async {
    final userData = await UserSession.getUser();
    final username = userData['username'] ?? '';
    if (mounted) {
      setState(() {
        _isGuest = username.isEmpty || username == 'Guest';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            const ResultStatusIndicator(status: 'FAIL', isPass: false),
            const SizedBox(height: 30),
            const ResultInfoCard(
              title: 'Reasons',
              content: 'Generate reasons for failure of the scanned report from backend ......................',
            ),
            const SizedBox(height: 24),
            const ResultInfoCard(
              title: 'Recommendations',
              content: 'Generate recommendations for the scanned report from backend saying how to pass emission test ......................',
            ),
            const SizedBox(height: 40),
            ViewDetailsButton(
              onPressed: () async {
                final userData = await UserSession.getUser();
                final username = userData['username'] ?? '';
                if (username.isEmpty || username == 'Guest') {
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const GuestUserHomePage()),
                      (route) => false,
                    );
                  }
                } else {
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreenSignupLogin()),
                      (route) => false,
                    );
                  }
                }
              },
              backgroundColor: _primaryGreen,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        isGuest: _isGuest,
        selectedIndex: _selectedIndex,
        primaryGreen: _primaryGreen,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _primaryGreen,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'View Report',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
