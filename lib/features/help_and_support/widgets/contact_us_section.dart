import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'help_support_components.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@ecosense.com',
      queryParameters: {
        'subject': 'EcoSense Help & Support Inquiry',
      },
    );
    try {
      await launchUrl(emailUri);
    } catch (e) {
      debugPrint('Could not launch email: $e');
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+94771234567',
    );
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      debugPrint('Could not launch phone: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Contact Us"),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              ContactTile(
                title: "Email",
                subtitle: "support@ecosense.com",
                icon: Icons.email,
                showArrow: false,
                onTap: _launchEmail,
              ),
              Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
              ContactTile(
                title: "Call us",
                subtitle: "+94 77 123 4567",
                icon: Icons.phone,
                showArrow: false,
                onTap: _launchPhone,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
