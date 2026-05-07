import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/user_info_text_field.dart';
import '../../data/user_session.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  String _username = 'Guest';

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
      final fullName = userData['full_name']!;
      if (fullName != 'Not set' && fullName.contains(' ')) {
        final names = fullName.split(' ');
        _firstNameController.text = names[0];
        _lastNameController.text = names.sublist(1).join(' ');
      } else {
        _firstNameController.text = fullName;
      }
      _emailController.text = userData['email']!;
      _contactController.text = userData['contact']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.person, size: 70.r, color: Colors.grey),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Icon(Icons.edit, size: 20.r, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              _username,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),

            // Form Fields
            UserInfoTextField(
              hint: 'First Name',
              controller: _firstNameController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            UserInfoTextField(
              hint: 'Last Name',
              controller: _lastNameController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            UserInfoTextField(
              hint: "User's mail",
              controller: _emailController,
              primaryGreen: primaryGreen,
            ),
            SizedBox(height: 15.h),
            UserInfoTextField(
              hint: 'Contact',
              controller: _contactController,
              primaryGreen: primaryGreen,
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
                onPressed: () async {
                  await UserSession.saveUser(
                    username: _username,
                    email: _emailController.text,
                    fullName: '${_firstNameController.text} ${_lastNameController.text}'.trim(),
                    contact: _contactController.text,
                  );
                  Navigator.pop(context, true);
                },
                child: Text(
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
}
