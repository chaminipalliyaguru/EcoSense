import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOverviewCard extends StatelessWidget {
  final Color primaryGreen;

  const AppOverviewCard({
    super.key,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "App Overview",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: primaryGreen,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.0.w),
          decoration: BoxDecoration(
            color: const Color(0xFFA1BBA4),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            "This application is for vehicle owners. After you have done emission testing, you can upload the report through camera. The app scans the report and gives the reason for failure (if failed) and also recommendations on how to fix it. It also provides recommendations to repair vehicle even for pass reports",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
