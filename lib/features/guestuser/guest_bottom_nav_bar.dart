import 'package:flutter/material.dart';

class GuestBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final Color primaryGreen;

  const GuestBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.primaryGreen = const Color(0xFF3A7D44),
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: primaryGreen,
      unselectedItemColor: Colors.grey,
      iconSize: 32,
      selectedFontSize: 16,
      unselectedFontSize: 14,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_outlined),
          activeIcon: Icon(Icons.camera),
          label: "Scan",
        ),
      ],
    );
  }
}
