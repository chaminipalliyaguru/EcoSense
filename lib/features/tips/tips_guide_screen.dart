import 'package:flutter/material.dart';
import '../home/widgets/bottom_nav_bar.dart';
import '../home/widgets/top_app_bar.dart';
import '../guestuser/guest_bottom_nav_bar.dart';
import 'widgets/tips_header.dart';
import 'widgets/how_to_do_it.dart';
import 'widgets/tips_for_better_results.dart';
import 'widgets/keep_your_vehicle_eco_friendly.dart';
import '../../widgets/button.dart';
import '../home/home_screen_signup_login.dart';

class TipsGuideScreen extends StatefulWidget {
  final bool isGuest;
  const TipsGuideScreen({super.key, this.isGuest = false});

  @override
  State<TipsGuideScreen> createState() => _TipsGuideScreenState();
}

class _TipsGuideScreenState extends State<TipsGuideScreen> {
  int _selectedIndex = 0;
  final Color _primaryGreen = const Color(0xFF4A7B59);

  @override
  Widget build(BuildContext context) {
    // Read isGuest from route arguments if provided
    final bool effectiveIsGuest =
        (ModalRoute.of(context)?.settings.arguments as bool?) ?? widget.isGuest;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(primaryGreen: _primaryGreen),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Tips Header
            TipsHeader(),
            SizedBox(height: 30),

            // 2. How To Do It (Step by step)
            HowToDoIt(),
            SizedBox(height: 30),

            // 3. Tips for better results
            TipsForBetterResults(),
            SizedBox(height: 30),

            // 4. Keep your Vehicle Eco-Friendly
            KeepYourVehicleEcoFriendly(),
            SizedBox(height: 40),

            //back to home button
            Button(
              text: "Back to Home",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreenSignupLogin(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],


        ),
      ),
      bottomNavigationBar: effectiveIsGuest
          ? GuestBottomNavBar(
              selectedIndex: _selectedIndex,
              onTap: (index) {
                if (index == 0) {
                  Navigator.pop(context);
                }
                setState(() => _selectedIndex = index);
              },
              primaryGreen: _primaryGreen,
            )
          : BottomNavBar(
              selectedIndex: _selectedIndex,
              onTap: (index) {
                if (index == 0) {
                  Navigator.pop(context);
                }
                setState(() => _selectedIndex = index);
              },
              primaryGreen: _primaryGreen,
            ),
    );
  }
}
