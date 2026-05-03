import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color primaryGreen;

  const TopAppBar({
    super.key,
    this.primaryGreen = const Color(0xFF3A7D44),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryGreen,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Image.asset(
        'assets/logo.png',
        height: 32.h,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
