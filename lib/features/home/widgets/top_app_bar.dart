import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color primaryGreen;
  final bool showBackButton;

  const TopAppBar({
    super.key,
    this.primaryGreen = const Color(0xFF3A7D44),
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryGreen,
      elevation: 0,
      automaticallyImplyLeading: false,

      // Show back arrow only when needed
      leading: showBackButton
          ? IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
          : null,

      // Hide logo when back button is shown
      title: showBackButton
          ? null
          : Image.asset(
        'assets/logo.png',
        height: 32.h,
        fit: BoxFit.contain,
      ),

      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}