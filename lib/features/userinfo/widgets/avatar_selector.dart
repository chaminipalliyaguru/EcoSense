import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarOption {
  final int id;
  final String name;
  final String title;
  final String assetPath;
  final Color bgColor;
  final IconData fallbackIcon;

  const AvatarOption({
    required this.id,
    required this.name,
    required this.title,
    required this.assetPath,
    required this.bgColor,
    required this.fallbackIcon,
  });
}

class AvatarData {
  static const List<AvatarOption> options = [
    AvatarOption(
      id: 0,
      name: 'Alex',
      title: 'Smart Male',
      assetPath: 'assets/images/avatars/avatar1.png',
      bgColor: Color(0xFFFFD166),
      fallbackIcon: Icons.account_circle_rounded,
    ),
    AvatarOption(
      id: 1,
      name: 'Sophia',
      title: 'Executive Female',
      assetPath: 'assets/images/avatars/avatar2.png',
      bgColor: Color(0xFF118AB2),
      fallbackIcon: Icons.account_box_rounded,
    ),
    AvatarOption(
      id: 2,
      name: 'Michael',
      title: 'Glasses Male',
      assetPath: 'assets/images/avatars/avatar3.png',
      bgColor: Color(0xFFF77F00),
      fallbackIcon: Icons.badge_rounded,
    ),
    AvatarOption(
      id: 3,
      name: 'Elena',
      title: 'Curly Female',
      assetPath: 'assets/images/avatars/avatar4.png',
      bgColor: Color(0xFF06D6A0),
      fallbackIcon: Icons.person_pin_rounded,
    ),
    AvatarOption(
      id: 4,
      name: 'David',
      title: 'Casual Male',
      assetPath: 'assets/images/avatars/avatar5.png',
      bgColor: Color(0xFFEF476F),
      fallbackIcon: Icons.work_rounded,
    ),
    AvatarOption(
      id: 5,
      name: 'Chloe',
      title: 'Director Female',
      assetPath: 'assets/images/avatars/avatar6.png',
      bgColor: Color(0xFF9C27B0),
      fallbackIcon: Icons.star_rounded,
    ),
  ];

  static AvatarOption getAvatar(int index) {
    if (index >= 0 && index < options.length) {
      return options[index];
    }
    return options[0];
  }
}

class UserAvatar extends StatelessWidget {
  final int avatarIndex;
  final double radius;
  final VoidCallback? onTap;
  final bool showEditBadge;
  final bool isGuest;

  const UserAvatar({
    super.key,
    required this.avatarIndex,
    this.radius = 35,
    this.onTap,
    this.showEditBadge = false,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGuest) {
      Widget guestCircle = CircleAvatar(
        radius: radius.r,
        backgroundColor: Colors.grey.shade300,
        child: Icon(
          Icons.person,
          size: (radius * 1.15).r,
          color: Colors.grey.shade600,
        ),
      );

      if (onTap != null) {
        return GestureDetector(
          onTap: onTap,
          child: guestCircle,
        );
      }
      return guestCircle;
    }

    final avatar = AvatarData.getAvatar(avatarIndex);

    Widget avatarContent = ClipOval(
      child: Image.asset(
        avatar.assetPath,
        width: (radius * 2).r,
        height: (radius * 2).r,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return CircleAvatar(
            radius: radius.r,
            backgroundColor: avatar.bgColor,
            child: Icon(
              avatar.fallbackIcon,
              size: (radius * 1.1).r,
              color: Colors.white,
            ),
          );
        },
      ),
    );

    Widget avatarCircle = Container(
      width: (radius * 2).r,
      height: (radius * 2).r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatar.bgColor,
        border: Border.all(color: Colors.white, width: 2.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: avatarContent,
    );

    if (showEditBadge) {
      avatarCircle = Stack(
        children: [
          avatarCircle,
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                size: (radius * 0.45).r,
                color: const Color(0xFF1E6D2F),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatarCircle,
      );
    }

    return avatarCircle;
  }
}

class AvatarSelectionSheet extends StatefulWidget {
  final int currentAvatarIndex;
  final ValueChanged<int> onSelectAvatar;

  const AvatarSelectionSheet({
    super.key,
    required this.currentAvatarIndex,
    required this.onSelectAvatar,
  });

  @override
  State<AvatarSelectionSheet> createState() => _AvatarSelectionSheetState();
}

class _AvatarSelectionSheetState extends State<AvatarSelectionSheet> {
  late int _selectedIndex;
  final Color _primaryGreen = const Color(0xFF1E6D2F);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentAvatarIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle indicator
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Text(
            'Choose Profile Avatar',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Select your profile avatar',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24.h),

          // Grid of 6 Local Avatars
          Wrap(
            spacing: 20.w,
            runSpacing: 20.h,
            alignment: WrapAlignment.center,
            children: AvatarData.options.map((avatar) {
              final isSelected = _selectedIndex == avatar.id;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = avatar.id;
                  });
                },
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? _primaryGreen : Colors.transparent,
                          width: 3.w,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          avatar.assetPath,
                          width: 64.r,
                          height: 64.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return CircleAvatar(
                              radius: 32.r,
                              backgroundColor: avatar.bgColor,
                              child: Icon(
                                avatar.fallbackIcon,
                                size: 34.r,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E6D2F),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 14.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 28.h),

          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              onPressed: () {
                widget.onSelectAvatar(_selectedIndex);
                Navigator.pop(context);
              },
              child: Text(
                'Save Avatar',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
