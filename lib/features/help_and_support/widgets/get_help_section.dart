import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'help_support_components.dart';

class GetHelpSection extends StatelessWidget {
  const GetHelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Get Help"),
        SizedBox(height: 12.h),
        const SeparateExpandableCard(
          title: "How to scan Report",
          icon: Icons.camera_alt,
          content: "Place the report on a flat surface with good lighting. Open the scan feature and align the document within the frame. Capture a clear, full image without blur or shadows.",
        ),
        SizedBox(height: 12.h),
        const SeparateExpandableCard(
          title: "Common Scanning Issues",
          icon: Icons.warning_rounded,
          content: "Blurry images, poor lighting, folded documents, or missing parts of the report can cause scanning errors. Make sure the document is fully visible and stable before capturing.",
        ),
        SizedBox(height: 12.h),
        const SeparateExpandableCard(
          title: "Incorrect Data Extraction",
          icon: Icons.search,
          content: "Incorrect results may happen if the image is unclear, text is faded, or parts of the report are cut off. Always ensure high-quality images for better accuracy.",
        ),
      ],
    );
  }
}
