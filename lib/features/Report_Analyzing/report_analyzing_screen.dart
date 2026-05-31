import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../EditDetails/edit_details_screen.dart';

class ReportAnalyzingScreen extends StatefulWidget {
  const ReportAnalyzingScreen({super.key});

  @override
  State<ReportAnalyzingScreen> createState() => _ReportAnalyzingScreenState();
}

class _ReportAnalyzingScreenState extends State<ReportAnalyzingScreen> {
  double _progress = 0.0;
  int _step = 0; // 0: Extracting, 1: Verifying, 2: Diagnostics, 3: Done
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSimulatedAnalysis();
  }

  void _startSimulatedAnalysis() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) return;
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.01;
          
          if (_progress > 0.4 && _step == 0) _step = 1;
          if (_progress > 0.7 && _step == 1) _step = 2;
          if (_progress >= 1.0 && _step == 2) _step = 3;
        } else {
          _timer?.cancel();
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!mounted) return;
            
            // --- HOW TO TEST ---
            // To force a specific screen, comment out the Random line below 
            // and manually set isPass to true (for Pass) or false (for Fail).
            
            final isPass = true; // UNCOMMENT THIS TO FORCE PASS SCREEN
            // final isPass = false; // UNCOMMENT THIS TO FORCE FAIL SCREEN
            
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditDetailsScreen(isPass: isPass),
              ),
            );
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF5A805E);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Report Analyzing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 60.h),
          
          _buildProgressCircle(primaryColor),
          
          SizedBox(height: 40.h),
          
          Text(
            'Analyzing emission report...',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
            child: Text(
              'Verifying data against Sri Lanka environmental standards and vehicle specifications.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
          
          SizedBox(height: 40.h),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  _buildStepItem(
                    title: 'Extracting data',
                    status: _step > 0 ? 'Completed' : 'In progress',
                    isDone: _step > 0,
                    isActive: _step == 0,
                    showLine: true,
                  ),
                  SizedBox(height: 12.h),
                  _buildStepItem(
                    title: 'Verifying authenticity',
                    status: _step > 1 ? 'Completed' : (_step == 1 ? 'In progress' : 'Pending'),
                    isDone: _step > 1,
                    isActive: _step == 1,
                    showLine: true,
                  ),
                  SizedBox(height: 12.h),
                  _buildStepItem(
                    title: 'Running AI diagnostics',
                    status: _step > 2 ? 'Completed' : (_step == 2 ? 'In progress' : 'Pending'),
                    isDone: _step > 2,
                    isActive: _step == 2,
                    showLine: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(Color color) {
    final double ringDiameter = 240.w;
    final double ringRadius = ringDiameter / 2;
    final double strokeWidth = 10.w;
    final double iconSize = 42.w;

    final double containerSize = ringDiameter + iconSize + 16.w;
    final double ringOffset = (containerSize - ringDiameter) / 2;

    final double dist = ringRadius + strokeWidth / 2 + 6.w + iconSize / 2;
    final double cx = containerSize / 2;
    final double cy = containerSize / 2;
    
    // sin(40°) = 0.6428, cos(40°) = 0.7660
    final double iconCenterX = cx + dist * 0.6428;
    final double iconCenterY = cy - dist * 0.7660;

    return Center(
      child: SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          children: [
            Positioned(
              left: ringOffset,
              top: ringOffset,
              width: ringDiameter,
              height: ringDiameter,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.12)),
              ),
            ),

            Positioned(
              left: ringOffset,
              top: ringOffset,
              width: ringDiameter,
              height: ringDiameter,
              child: CircularProgressIndicator(
                value: _progress,
                strokeWidth: strokeWidth,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeCap: StrokeCap.round,
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 46.sp,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    'PROCESSING',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              left: iconCenterX - iconSize / 2,
              top: iconCenterY - iconSize / 2,
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.25), width: 1.5.w),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.15),
                      blurRadius: 8.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.show_chart,
                  color: color,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required String title,
    required String status,
    required bool isDone,
    required bool isActive,
    required bool showLine,
  }) {
    final color = isDone ? const Color(0xFF5A805E) : (isActive ? const Color(0xFF5A805E) : Colors.grey.shade400);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone ? color : Colors.white,
                  border: Border.all(
                    color: isDone ? color : (isActive ? color : Colors.grey.shade300),
                    width: 2.w,
                  ),
                ),
                child: isDone
                    ? Icon(Icons.check, size: 18.sp, color: Colors.white)
                    : (isActive 
                        ? Center(child: SizedBox(width: 12.w, height: 12.w, child: CircularProgressIndicator(strokeWidth: 2.w, valueColor: AlwaysStoppedAnimation(color))))
                        : null),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: isDone ? color : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isActive || isDone ? const Color(0xFF1E293B) : Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDone ? const Color(0xFF5A805E) : (isActive ? Colors.black45 : Colors.grey.shade400),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
