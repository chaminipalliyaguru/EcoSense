import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeroSection extends StatefulWidget {
  const HomeHeroSection({super.key});

  @override
  State<HomeHeroSection> createState() => _HomeHeroSectionState();
}

class _HomeHeroSectionState extends State<HomeHeroSection> {
  late PageController _pageController;
  int _realIndex = 1000; // Start at a large index for "infinite" feel
  Timer? _timer;

  final List<Map<String, dynamic>> _slides = [
    {
      'type': 'hero',
      'line1': 'Your Vehicle,',
      'line2': 'Your Environment,',
      'line3': 'Our Future.',
      'image': 'assets/images/home/home-your-vehical.png',
    },
    {
      'type': 'tip',
      'title': 'Regular',
      'subtitle': 'Maintenance',
      'detail': 'Service your vehicle regularly for better performance',
      'icon': Icons.build_outlined,
    },
    {
      'type': 'tip',
      'title': 'Check',
      'subtitle': 'Emissions',
      'detail': 'Keep your emissions in check for cleaner environment',
      'icon': Icons.eco_outlined,
    },
    {
      'type': 'tip',
      'title': 'Drive',
      'subtitle': 'Smart',
      'detail': 'Avoid idling and drive smoothly to reduce emissions',
      'icon': Icons.speed_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controller at the real index
    _pageController = PageController(initialPage: _realIndex);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _realIndex++;
        _pageController.animateToPage(
          _realIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1E6D2F);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        height: 160.h, // Fixed height for consistent layout
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            _realIndex = index;
          },
          // No itemCount for "infinite" scroll
          itemBuilder: (context, index) {
            final slide = _slides[index % _slides.length];
            return Row(
              children: [
                // Left Side: Text
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildSlideContent(slide, primaryGreen),
                  ),
                ),
                // Right Side: Image or Icon
                Expanded(
                  flex: 2,
                  child: slide['type'] == 'hero'
                      ? Image.asset(
                          slide['image'],
                          fit: BoxFit.contain,
                        )
                      : Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            slide['icon'],
                            size: 80.sp,
                            color: primaryGreen.withValues(alpha: 0.15),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildSlideContent(Map<String, dynamic> slide, Color primaryGreen) {
    if (slide['type'] == 'hero') {
      return [
        Text(
          slide['line1'],
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0.2,
          ),
        ),
        Text(
          slide['line2'],
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            color: primaryGreen,
            letterSpacing: 0.2,
          ),
        ),
        Text(
          slide['line3'],
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0.2,
          ),
        ),
      ];
    } else {
      return [
        Text(
          slide['title'],
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0.2,
          ),
        ),
        Text(
          slide['subtitle'],
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            color: primaryGreen,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          slide['detail'],
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
            height: 1.2,
          ),
        ),
      ];
    }
  }
}
