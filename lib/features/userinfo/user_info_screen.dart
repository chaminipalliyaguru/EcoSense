import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bottom_nav.dart';
import 'widgets/profile_header.dart';
import 'widgets/info_section_header.dart';
import 'widgets/user_info_text_field.dart';
import 'widgets/account_setting_tile.dart';
import '../../data/user_session.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();

  String _username = 'Guest';
  String _email = 'Not set';

  final Color primaryGreen = const Color(0xFF4A7B59);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await UserSession.getUser();
    setState(() {
      _username = userData['username']!;
      _email = userData['email']!;
      _fullNameController.text = userData['full_name']!;
      _emailController.text = _email;
      _contactController.text = userData['contact']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Image.asset(
          'assets/logo.png',
          height: 35.h,
          fit: BoxFit.contain,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              username: _username,
              email: _email,
              onEditPressed: () async {
                final result = await Navigator.pushNamed(context, '/edit_profile');
                if (result == true) {
                  _loadUserData();
                }
              },
            ),
            SizedBox(height: 30.h),

            // User Information Section
            InfoSectionHeader(
              icon: Icons.account_circle_outlined,
              title: 'User Information',
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            UserInfoTextField(
              hint: 'Full Name',
              controller: _fullNameController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            UserInfoTextField(
              hint: 'Email Addresses',
              controller: _emailController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            UserInfoTextField(
              hint: 'Contact',
              controller: _contactController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            UserInfoTextField(
              hint: 'Diving licenses Number',
              controller: _licenseController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 30.h),

            // Account Settings Section
            InfoSectionHeader(
              icon: Icons.lock_outline,
              title: 'Account Settings',
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            AccountSettingTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your account password',
              primaryGreen: primaryGreen,
              onTap: () {
                Navigator.pushNamed(context, '/verify_email', arguments: true);
              },
            ),
            SizedBox(height: 40.h),

            // Back to Home Button
            _buildBackToHomeButton(context),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        isGuest: false,
        selectedIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/login_home');
          }
        },
        primaryGreen: primaryGreen,
      ),
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.w,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home, color: Colors.white),
              SizedBox(width: 8.w),
              Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
