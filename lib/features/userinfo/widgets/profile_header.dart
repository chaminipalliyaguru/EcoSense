import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'avatar_selector.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final int avatarIndex;
  final VoidCallback onEditPressed;
  final VoidCallback? onAvatarPressed;
  final bool isGuest;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
    this.avatarIndex = 0,
    required this.onEditPressed,
    this.onAvatarPressed,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool effectiveGuest = isGuest || username == 'Guest';
    return Row(
      children: [
        UserAvatar(
          avatarIndex: avatarIndex,
          radius: 35,
          isGuest: effectiveGuest,
          showEditBadge: !effectiveGuest,
          onTap: effectiveGuest ? onEditPressed : (onAvatarPressed ?? onEditPressed),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: onEditPressed,
          icon: Icon(Icons.edit_outlined, size: 18.sp, color: Colors.grey),
          label: Text(
            'Edit profile',
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
