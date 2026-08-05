import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/get_help_section.dart';
import 'widgets/common_questions_section.dart';
import 'widgets/contact_us_section.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  final Color _primaryGreen = const Color(0xFF4A7B59);
  final Color _backgroundColor = const Color(0xFFF2F2F2); // Light grey background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Help & Support",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "We're here to assist you with anything\nyou need",
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            SizedBox(height: 30.h),

            const GetHelpSection(),
            SizedBox(height: 24.h),

            const CommonQuestionsSection(),
            SizedBox(height: 24.h),

            const ContactUsSection(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
