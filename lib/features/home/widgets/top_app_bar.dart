import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color primaryGreen;

  const TopAppBar({
    super.key,
    this.primaryGreen = const Color(0xFF4A7B59),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryGreen,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.eco,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            "EmissionAI",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            // Handle notification
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
