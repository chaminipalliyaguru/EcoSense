import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final VoidCallback onEditPressed;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35.r,
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.person, size: 50.r, color: Colors.grey),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: onEditPressed,
          icon: Icon(Icons.edit_outlined, size: 18.sp, color: Colors.grey),
          label: Text(
            'Edit profile',
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
