import 'package:flutter/material.dart';
import '../home/widgets/bottom_nav_bar.dart';
import 'widgets/result_status_indicator.dart';
import 'widgets/result_info_card.dart';
import 'widgets/view_details_button.dart';
import '../EditDetails/edit_details_screen.dart';
import '../../data/user_session.dart';
import '../guestuser/guest_user_home_page.dart';
import '../home/home_screen_signup_login.dart';

class PassReportScreen extends StatefulWidget {
  const PassReportScreen({super.key});

  @override
  State<PassReportScreen> createState() => _PassReportScreenState();
}

class _PassReportScreenState extends State<PassReportScreen> {
  int _selectedIndex = 1; 
  final Color _primaryGreen = const Color(0xFF5A805E);

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
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
            const ResultStatusIndicator(status: 'PASS', isPass: true),
            const SizedBox(height: 40),
            const ResultInfoCard(
              title: 'Recommendations',
              content: 'Generate recommendations for the scanned report from backend that how to improve vehicle',
            ),
            const SizedBox(height: 60),
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
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
