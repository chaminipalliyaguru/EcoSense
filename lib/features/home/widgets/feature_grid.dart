import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.history,
                    iconColor: Colors.teal,
                    iconBg: Colors.teal.shade50,
                    title: 'History',
                    subtitle: 'View your past scan\nreport and results',
                    onTap: () {
                      // TODO: Navigate to History
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.lightbulb_outline,
                    iconColor: Colors.orange,
                    iconBg: Colors.orange.shade50,
                    title: 'Tips & How To',
                    subtitle:
                        'Helpful tips and guides\nto keep your vehicle in\ngood condition',
                    onTap: () {
                      // TODO: Navigate to Tips
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.info_outline,
                    iconColor: Colors.blue,
                    iconBg: Colors.blue.shade50,
                    title: 'About',
                    subtitle: 'Learn more about\nthe app and our\nmission',
                    onTap: () {
                      // TODO: Navigate to About
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.support_agent,
                    iconColor: Colors.purple,
                    iconBg: Colors.purple.shade50,
                    title: 'Help and Support',
                    subtitle:
                        'Need help? Contact\nour support team',
                    onTap: () {
                      // TODO: Navigate to Support
                    },
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

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: iconColor, size: 28.sp), // Adjusted icon size
              ),
              SizedBox(height: 10.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp, // Adjusted font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp, // Adjusted font size
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
