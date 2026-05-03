import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanBottomBar extends StatelessWidget {
  final Color primaryGreen;
  final VoidCallback onGalleryTap;
  final VoidCallback onCaptureTap;
  final VoidCallback onFlipTap;

  const ScanBottomBar({
    super.key,
    required this.primaryGreen,
    required this.onGalleryTap,
    required this.onCaptureTap,
    required this.onFlipTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Gallery
          _ActionButton(
            icon: Icons.image_outlined,
            onTap: onGalleryTap,
          ),

          // Capture
          GestureDetector(
            onTap: onCaptureTap,
            child: Container(
              width: 68.w,
              height: 68.w,
              decoration: BoxDecoration(
                color: primaryGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryGreen.withValues(alpha: 0.35),
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
          ),

          // Flip camera
          _ActionButton(
            icon: Icons.flip_camera_ios_outlined,
            onTap: onFlipTap,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 24.sp, color: Colors.black87), // Adjusted size
      ),
    );
  }
}
