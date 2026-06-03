import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CertificateInfoCard extends StatelessWidget {
  final String certificateNo;
  final String dateOfIssue;

  const CertificateInfoCard({
    super.key,
    required this.certificateNo,
    required this.dateOfIssue,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: isPortrait ? 20.h : 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: isPortrait
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Certificate No.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  certificateNo,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Date of Issue',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  dateOfIssue,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Certificate No.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        certificateNo,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 30.h,
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date of Issue',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        dateOfIssue,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
