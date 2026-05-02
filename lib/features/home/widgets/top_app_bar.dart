import 'package:flutter/material.dart';

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
      title: const Text(
        'Logo',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
