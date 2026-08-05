import 'dart:async';
import 'dart:io';
import '../../services/api_service.dart';
import '../EditDetails/edit_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportAnalyzingScreen extends StatefulWidget {
  final File imageFile;

  const ReportAnalyzingScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<ReportAnalyzingScreen> createState() => _ReportAnalyzingScreenState();
}

class _ReportAnalyzingScreenState extends State<ReportAnalyzingScreen> {
  double _progress = 0.0;
  int _step = 0; // 0: Extracting, 1: Verifying, 2: Diagnostics, 3: Done
  Timer? _timer;


  Future<void> _startAnalysis() async {
    try {
      if (!mounted) return;

      // =========================
      // STEP 1: Show start state
      // =========================
      setState(() {
        _step = 0; // Extracting data
        _progress = 0.2;
      });

      // Small delay for UX (optional but makes UI smooth)
      await Future.delayed(const Duration(milliseconds: 500));

      // =========================
      // STEP 2: Upload + Analyze
      // =========================
      setState(() {
        _step = 1; // Verifying authenticity
        _progress = 0.5;
      });

      final result = await ApiService.uploadReport(
        widget.imageFile,
      );

      // =========================
      // STEP 3: Processing result
      // =========================
      setState(() {
        _step = 2; // AI diagnostics done
        _progress = 0.9;
      });

      await Future.delayed(const Duration(milliseconds: 300));

      // Final step
      setState(() {
        _step = 3;
        _progress = 1.0;
      });

      await Future.delayed(const Duration(milliseconds: 400));

      if (!mounted) return;

      // =========================
      // NAVIGATE TO NEXT SCREEN
      // =========================
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EditDetailsScreen(
            isPass: result["overall_result"] == "PASS",
            apiData: result,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Analysis failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startAnalysis();
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          if (isPortrait) {
            return Column(
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
            );
          } else {
            // Side-by-side Landscape Dashboard Layout
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side: Progress circle & descriptive text
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildProgressCircle(primaryColor),
                        SizedBox(height: 16.h),
                        Text(
                          'Analyzing emission report...',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                          child: Text(
                            'Verifying data against Sri Lanka environmental standards and vehicle specifications.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 24.w),
                  // Right side: Steps Checklist
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        _buildStepItem(
                          title: 'Extracting data',
                          status: _step > 0 ? 'Completed' : 'In progress',
                          isDone: _step > 0,
                          isActive: _step == 0,
                          showLine: true,
                        ),
                        SizedBox(height: 8.h),
                        _buildStepItem(
                          title: 'Verifying authenticity',
                          status: _step > 1 ? 'Completed' : (_step == 1 ? 'In progress' : 'Pending'),
                          isDone: _step > 1,
                          isActive: _step == 1,
                          showLine: true,
                        ),
                        SizedBox(height: 8.h),
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
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProgressCircle(Color color) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final double ringDiameter = isPortrait ? 240.w : 160.w;
    final double ringRadius = ringDiameter / 2;
    final double strokeWidth = isPortrait ? 10.w : 8.w;
    final double iconSize = isPortrait ? 42.w : 32.w;

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
                      fontSize: isPortrait ? 46.sp : 32.sp,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    'PROCESSING',
                    style: TextStyle(
                      fontSize: isPortrait ? 13.sp : 11.sp,
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
                  size: isPortrait ? 22.sp : 16.sp,
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
