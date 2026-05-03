import 'dart:async';
import 'package:flutter/material.dart';

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
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.01;
          
          // Update steps based on progress
          if (_progress > 0.4 && _step == 0) _step = 1;
          if (_progress > 0.7 && _step == 1) _step = 2;
          if (_progress >= 1.0 && _step == 2) _step = 3;
        } else {
          _timer?.cancel();
          // TODO: Navigate to results screen after a short delay
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
    final primaryColor = const Color(0xFF5A805E); // Green from the image

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Report Analyzing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          
          // ── Progress Circle ──
          _buildProgressCircle(primaryColor),
          
          const SizedBox(height: 40),
          
          // ── Header Text ──
          const Text(
            'Analyzing emission report...',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              'Verifying data against Sri Lanka environmental standards and vehicle specifications.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // ── Steps Checklist ──
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  _buildStepItem(
                    title: 'Extracting data',
                    status: _step > 0 ? 'Completed' : 'In progress',
                    isDone: _step > 0,
                    isActive: _step == 0,
                    showLine: true,
                  ),
                  const SizedBox(height: 12),
                  _buildStepItem(
                    title: 'Verifying authenticity',
                    status: _step > 1 ? 'Completed' : (_step == 1 ? 'In progress' : 'Pending'),
                    isDone: _step > 1,
                    isActive: _step == 1,
                    showLine: true,
                  ),
                  const SizedBox(height: 12),
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
    // Ring is 240px diameter (radius = 120)
    const double ringDiameter = 240.0;
    const double ringRadius = ringDiameter / 2;
    const double strokeWidth = 10.0;
    const double iconSize = 42.0;

    // Container is larger to give room for the icon outside the ring
    const double containerSize = ringDiameter + iconSize + 16;
    // Ring is centered in the container
    const double ringOffset = (containerSize - ringDiameter) / 2;

    // Icon placed OUTSIDE the ring at 40° (1 o'clock) from top
    // Distance from center = ring outer edge + gap + icon radius
    const double dist = ringRadius + strokeWidth / 2 + 6 + iconSize / 2;
    const double cx = containerSize / 2;
    const double cy = containerSize / 2;
    // sin(40°) = 0.6428, cos(40°) = 0.7660
    const double iconCenterX = cx + dist * 0.6428;
    const double iconCenterY = cy - dist * 0.7660;

    return Center(
      child: SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          children: [
            // ── Background track ring ──
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

            // ── Animated progress arc ──
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

            // ── Percentage & label text ──
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const Text(
                    'PROCESSING',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),

            // ── Icon badge OUTSIDE the ring at 1 o'clock ──
            Positioned(
              left: iconCenterX - iconSize / 2,
              top: iconCenterY - iconSize / 2,
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.25), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.show_chart,
                  color: color,
                  size: 22,
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
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone ? color : Colors.white,
                  border: Border.all(
                    color: isDone ? color : (isActive ? color : Colors.grey.shade300),
                    width: 2,
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check, size: 18, color: Colors.white)
                    : (isActive 
                        ? Center(child: SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(color))))
                        : null),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isDone ? color : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive || isDone ? const Color(0xFF1E293B) : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDone ? const Color(0xFF5A805E) : (isActive ? Colors.black45 : Colors.grey.shade400),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
