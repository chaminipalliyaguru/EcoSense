import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokeOpacityChart extends StatelessWidget {
  final List<double> smokeDensities;
  final double avgSmokeDensity;
  final Color primaryGreen;

  const SmokeOpacityChart({
    super.key,
    required this.smokeDensities,
    required this.avgSmokeDensity,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      width: double.infinity,
      height: isPortrait 
          ? 150.h.clamp(130.0, 250.0)
          : 110.h.clamp(95.0, 160.0),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: isPortrait ? 14.h : 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Smoke Opacity (K-1/m)',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: CustomPaint(
                size: Size.infinite,
                painter: SmokeOpacityChartPainter(
                  smokeDensities: smokeDensities,
                  average: avgSmokeDensity,
                  primaryColor: primaryGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmokeOpacityChartPainter extends CustomPainter {
  final List<double> smokeDensities;
  final double average;
  final Color primaryColor;

  SmokeOpacityChartPainter({
    required this.smokeDensities,
    required this.average,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    // Bottom padding for text
    const labelHeight = 20.0;
    final graphHeight = h - labelHeight;

    // Draw background grid lines (horizontal)
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1.0;
    
    final gridLevels = [0.0, 0.25, 0.5, 0.75, 1.0];
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var level in gridLevels) {
      final y = graphHeight * (1.0 - level);
      canvas.drawLine(Offset(20.0, y), Offset(w, y), gridPaint);
      
      // Draw grid text label
      textPainter.text = TextSpan(
        text: level.toStringAsFixed(2),
        style: TextStyle(color: Colors.grey.shade400, fontSize: 8.sp, fontWeight: FontWeight.w600),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - 5.h));
    }

    // Connect data points: Snap 1, Snap 2, Snap 3
    final points = <Offset>[];
    final xPositions = [
      20.0 + (w - 20.0) * 0.15,
      20.0 + (w - 20.0) * 0.5,
      20.0 + (w - 20.0) * 0.85,
    ];

    for (int i = 0; i < smokeDensities.length; i++) {
      // Clamp value to 0..1 range for rendering inside graph
      double smokeVal = smokeDensities[i];
      if (smokeVal < 0.0) smokeVal = 0.0;
      if (smokeVal > 1.0) smokeVal = 1.0;

      final y = graphHeight * (1.0 - smokeVal);
      points.add(Offset(xPositions[i], y));
      
      // Draw snap label below x-axis
      textPainter.text = TextSpan(
        text: 'Snap ${i + 1}',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 9.sp, fontWeight: FontWeight.bold),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(xPositions[i] - textPainter.width / 2, graphHeight + 4.h));
    }

    if (points.isNotEmpty) {
      // Draw gradient under line
      final fillPath = Path()
        ..moveTo(points.first.dx, graphHeight)
        ..lineTo(points.first.dx, points.first.dy);
      
      for (int i = 1; i < points.length; i++) {
        fillPath.lineTo(points[i].dx, points[i].dy);
      }
      fillPath.lineTo(points.last.dx, graphHeight);
      fillPath.close();

      final fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor.withValues(alpha: 0.3),
            primaryColor.withValues(alpha: 0.01),
          ],
        ).createShader(Rect.fromLTWH(20.0, 0, w - 20.0, graphHeight));
      canvas.drawPath(fillPath, fillPaint);

      // Draw lines connecting points
      final linePaint = Paint()
        ..color = primaryColor
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      
      final linePath = Path()..moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        linePath.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(linePath, linePaint);

      // Draw dot indicators and value labels
      final dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      final strokePaint = Paint()
        ..color = primaryColor
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < points.length; i++) {
        canvas.drawCircle(points[i], 4.0, dotPaint);
        canvas.drawCircle(points[i], 4.0, strokePaint);

        // Value text
        textPainter.text = TextSpan(
          text: smokeDensities[i].toStringAsFixed(2),
          style: TextStyle(color: primaryColor, fontSize: 10.sp, fontWeight: FontWeight.bold),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(points[i].dx - textPainter.width / 2, points[i].dy - 16.h));
      }
    }
  }

  @override
  bool shouldRepaint(covariant SmokeOpacityChartPainter oldDelegate) {
    return oldDelegate.average != average || oldDelegate.smokeDensities != smokeDensities;
  }
}
