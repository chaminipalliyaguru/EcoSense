import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'help_support_components.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Contact US"),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              const ContactTile(
                title: "Email",
                subtitle: "support@ecosense.com",
                icon: Icons.email,
                showArrow: false,
              ),
              Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
              const ContactTile(
                title: "Call Us",
                subtitle: "+94 77 123 4567",
                icon: Icons.phone,
                showArrow: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
