import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Color primaryGreen;

  const UserInfoTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final bool isContactField = hint.toLowerCase().contains('contact');
    return TextField(
      controller: controller,
      keyboardType: isContactField ? TextInputType.phone : TextInputType.text,
      inputFormatters: isContactField
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ]
          : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: primaryGreen),
        ),
      ),
    );
  }
}
