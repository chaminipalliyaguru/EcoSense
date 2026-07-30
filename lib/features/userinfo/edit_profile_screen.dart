import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/user_info_text_field.dart';
import 'widgets/avatar_selector.dart';
import '../../data/user_session.dart';
import '../../services/api_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String _username = 'Guest';
  int _avatarIndex = 0;
  bool _isLoading = false;

  final Color primaryGreen = const Color(0xFF4A7B59);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await UserSession.getUser();
    if (mounted) {
      setState(() {
        _username = userData['username']!;
        _usernameController.text = userData['username']!;
        _fullNameController.text = userData['full_name']!;
        _emailController.text = userData['email']!;
        _avatarIndex = userData['avatar_index'] ?? 0;
      });
    }

    final apiData = await ApiService.getUserDetails();
    if (apiData['status'] != 'error') {
      if (mounted) {
        setState(() {
          _username = apiData['username'] ?? _username;
          _usernameController.text = apiData['username'] ?? _usernameController.text;
          _fullNameController.text = apiData['full_name'] ?? _fullNameController.text;
          _emailController.text = apiData['email'] ?? _emailController.text;
        });
      }
      await UserSession.saveUser(
        username: _username,
        email: _emailController.text,
        fullName: _fullNameController.text,
      );
    }
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: Image.asset(
          'assets/logo.png',
          height: 35.h,
          fit: BoxFit.contain,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        child: Column(
          children: [
            // Profile Image with Edit Icon
            Center(
              child: UserAvatar(
                avatarIndex: _avatarIndex,
                radius: 50,
                showEditBadge: true,
                onTap: _showAvatarSelectionSheet,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              _fullNameController.text.isNotEmpty ? _fullNameController.text : _username,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),

            // Form Fields
            _buildFieldLabel('Full Name'),
            UserInfoTextField(
              hint: 'Enter your full name',
              controller: _fullNameController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            _buildFieldLabel('Username'),
            UserInfoTextField(
              hint: "Username",
              controller: _usernameController,
              primaryGreen: primaryGreen,
              readOnly: true,
            ),
            SizedBox(height: 15.h),
            _buildFieldLabel('Email Address'),
            UserInfoTextField(
              hint: "Email address",
              controller: _emailController,
              primaryGreen: primaryGreen,
              readOnly: true,
            ),
            SizedBox(height: 40.h),

            // Save Changes Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() => _isLoading = true);
                        final newName = _fullNameController.text.trim();
                        final result = await ApiService.changeName(newName);

                        setState(() => _isLoading = false);

                        if (result['status'] == 'success' || result['message'] == 'Name updated') {
                          await UserSession.saveUser(
                            username: _username,
                            email: _emailController.text,
                            fullName: newName,
                          );
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Name updated successfully')),
                          );
                          Navigator.pop(context, true);
                        } else {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result['message'] ?? 'Update failed')),
                          );
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Save Changes',
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
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
