import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickTipsSection extends StatelessWidget {
  final Color primaryGreen;

  const QuickTipsSection({
    super.key,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Tips',
            style: TextStyle(
              fontSize: 20.sp, // Adjusted
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _QuickTipItem(
                icon: Icons.build_outlined,
                label: 'Regular\nMaintenance',
                detail:
                    'Service your vehicle\nregularly for better\nperformance',
                primaryGreen: primaryGreen,
              ),
              _QuickTipItem(
                icon: Icons.eco_outlined,
                label: 'Check\nEmissions',
                detail:
                    'Keep your emissions\nin check for cleaner\nenvironment',
                primaryGreen: primaryGreen,
              ),
              _QuickTipItem(
                icon: Icons.speed_outlined,
                label: 'Drive\nSmart',
                detail:
                    'Avoid idling and drive\nsmoothly to reduce\nemissions',
                primaryGreen: primaryGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickTipItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;
  final Color primaryGreen;

  const _QuickTipItem({
    required this.icon,
    required this.label,
    required this.detail,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Icon(icon, color: primaryGreen, size: 30.sp), // Adjusted
          ),
          SizedBox(height: 10.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp, // Adjusted
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp, // Adjusted
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
