import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'help_support_components.dart';

class CommonQuestionsSection extends StatelessWidget {
  const CommonQuestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Common Questions"),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              const GroupedExpandableTile(
                title: "How do I scan a report?",
                content: "Open the scan option in the app, position your report inside the frame, and take a clear photo. Wait a few seconds for the system to process and extract the data.",
              ),
              Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
              const GroupedExpandableTile(
                title: "Why are my results incorrect?",
                content: "Results may be incorrect due to blurry images, poor lighting, handwritten text, or incomplete document capture. Try rescanning with better quality images.",
              ),
              Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
              const GroupedExpandableTile(
                title: "How can I edit extracted data?",
                content: "After scanning, review the extracted results and tap on any field to edit it manually. Save the changes once you have corrected the information.",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
