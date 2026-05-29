import 'dart:io';
import 'package:flutter/material.dart';

import './widgets/image_card.dart';
import './widgets/snap_data_card.dart';
import './widgets/status_card.dart';
import './widgets/action_buttons.dart';

class DataVerificationScreen extends StatefulWidget {
  final File? imageFile;
  final VoidCallback onRetake;
  final VoidCallback onConfirm;

  const DataVerificationScreen({
    super.key,
    required this.imageFile,
    required this.onRetake,
    required this.onConfirm,
  });

  @override
  State<DataVerificationScreen> createState() => _DataVerificationScreenState();
}

class _DataVerificationScreenState extends State<DataVerificationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Instruction
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please review and confirm the extracted data before proceeding.",
                ),
              ),
              const SizedBox(height: 16),

              /// Image Preview
              ImageCard(
                imageFile: widget.imageFile,
                onRetake: widget.onRetake,
              ),

              const SizedBox(height: 20),

              /// Swipeable Snap Cards
              SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 5,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: SnapDataCard(
                        title: "Snap Data ${index + 1}",
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              /// Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 10 : 6,
                    height: _currentPage == index ? 10 : 6,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),

              /// Status Card
              const StatusCard(
                icon: Icons.speed,
                title: "Fleet Performance",
                value: "Within Range",
                color: Colors.green,
              ),

              const SizedBox(height: 10),

              /// Action Buttons
              ActionButtons(
                onRetake: widget.onRetake,
                onConfirm: widget.onConfirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
