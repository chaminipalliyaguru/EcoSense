import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color primaryGreen;

  const InfoSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: primaryGreen, size: 24.sp),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
