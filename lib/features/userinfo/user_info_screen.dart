import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bottom_nav.dart';
import 'widgets/profile_header.dart';
import 'widgets/info_section_header.dart';
import 'widgets/user_info_text_field.dart';
import 'widgets/account_setting_tile.dart';
import 'widgets/avatar_selector.dart';
import '../../data/user_session.dart';
import '../login_and_signup/login_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import 'widgets/logout_button.dart';
import '../splash/welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _username = 'Guest';
  String _email = '';
  int _avatarIndex = 0;

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
      _avatarIndex = userData['avatar_index'] ?? 0;
    });
  }

  void _showAvatarSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AvatarSelectionSheet(
        currentAvatarIndex: _avatarIndex,
        onSelectAvatar: (newIndex) async {
          setState(() {
            _avatarIndex = newIndex;
          });
          await UserSession.saveAvatarIndex(newIndex);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Avatar updated successfully!')),
          );
        },
      ),
    );
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
              username: _fullNameController.text.isNotEmpty ? _fullNameController.text : _username,
              email: _email,
              avatarIndex: _avatarIndex,
              onAvatarPressed: _showAvatarSelectionSheet,
              onEditPressed: () async {
                if (_username == 'Guest') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else {
                  final result = await Navigator.pushNamed(context, '/edit_profile');
                  if (result == true) {
                    _loadUserData();
                  }
                }
              },
            ),
            SizedBox(height: 30.h),

            if (_username == 'Guest') ...[
              SizedBox(height: 40.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Please sign in to access your profile settings.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
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
              SizedBox(height: 30.h),
              
              // Account Settings Section
              InfoSectionHeader(
                icon: Icons.lock_outline,
                title: 'Account Settings',
                primaryGreen: primaryGreen,
              ),
              SizedBox(height: 15.h),
              AccountSettingTile(
                icon: Icons.face_rounded,
                title: 'Choose Avatar',
                subtitle: 'Select from 5 profile avatars',
                primaryGreen: primaryGreen,
                onTap: _showAvatarSelectionSheet,
              ),
              SizedBox(height: 15.h),
              AccountSettingTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your account password',
                primaryGreen: primaryGreen,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(
                        email: _email,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40.h),
              
              LogoutButton(
                onPressed: () async {
                  await UserSession.clear();
                  try {
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    if (await googleSignIn.isSignedIn()) {
                      await googleSignIn.signOut();
                    }
                  } catch (e) {
                    debugPrint("Google SignOut Error: $e");
                  }
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      (route) => false,
                    );
                  }
                },
              ),
              SizedBox(height: 20.h),
            ],
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        isGuest: _username == 'Guest',
        selectedIndex: 3,
        primaryGreen: primaryGreen,
      ),
    );
  }
}
