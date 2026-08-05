import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;
  final Color primaryGreen;

  const PasswordRequirements({
    super.key,
    required this.password,
    this.primaryGreen = const Color(0xFF4A7B59),
  });

  Widget _buildRequirementItem(String text, bool isMet) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
          color: isMet ? primaryGreen : Colors.grey.shade400,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: isMet ? primaryGreen : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final hasMinLength = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~]'));

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password Requirements:",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 8.h,
            children: [
              _buildRequirementItem("Min. 8 characters", hasMinLength),
              _buildRequirementItem("1 uppercase letter", hasUppercase),
              _buildRequirementItem("1 number", hasNumber),
              _buildRequirementItem("1 special character", hasSpecialChar),
            ],
          ),
        ],
      ),
    );
  }
}
