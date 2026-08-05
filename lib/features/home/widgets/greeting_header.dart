import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../userinfo/widgets/avatar_selector.dart';

class GreetingHeader extends StatelessWidget {
  final String name;
  final String subtitle;
  final int avatarIndex;
  final bool isGuest;

  const GreetingHeader({
    super.key,
    required this.name,
    this.subtitle = "Let's keep your vehicle eco-friendly",
    this.avatarIndex = 0,
    this.isGuest = false,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }


  @override
  Widget build(BuildContext context) {
    final bool effectiveGuest = isGuest || name.isEmpty || name == 'Guest';
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Row(
        children: [
          // Avatar
          UserAvatar(
            avatarIndex: avatarIndex,
            radius: 28,
            isGuest: effectiveGuest,
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (name.isEmpty) ...[
                Text(
                  '${_getGreeting()}!',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ] else ...[
                Text(
                  '${_getGreeting()},',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
