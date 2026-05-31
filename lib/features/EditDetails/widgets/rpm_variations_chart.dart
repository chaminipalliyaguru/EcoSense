import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RpmVariationsChart extends StatelessWidget {
  final List<int> rpms;

  const RpmVariationsChart({
    super.key,
    required this.rpms,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RPM Variations (Stability Test)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'TARGET',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'ACTUAL',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: CustomPaint(
                size: Size.infinite,
                painter: RpmVariationsChartPainter(
                  rpms: rpms,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RpmVariationsChartPainter extends CustomPainter {
  final List<int> rpms;

  RpmVariationsChartPainter({
    required this.rpms,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    const labelHeight = 20.0;
    final graphHeight = h - labelHeight;

    // Draw background grid lines (horizontal)
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1.0;
    
    final gridLevels = [0, 1000, 2000, 3000, 4000];
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var level in gridLevels) {
      final y = graphHeight * (1.0 - (level / 4000.0));
      canvas.drawLine(Offset(24.0, y), Offset(w, y), gridPaint);
      
      // Draw grid text label
      textPainter.text = TextSpan(
        text: level.toString(),
        style: TextStyle(color: Colors.grey.shade400, fontSize: 8.sp, fontWeight: FontWeight.w600),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - 5.h));
    }

    // Draw Target Line (3300 RPM)
    final targetY = graphHeight * (1.0 - (3300.0 / 4000.0));
    final targetPaint = Paint()
      ..color = Colors.green.shade600
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    // Draw a dashed green line
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 24.0;
    while (startX < w) {
      canvas.drawLine(Offset(startX, targetY), Offset(startX + dashWidth, targetY), targetPaint);
      startX += dashWidth + dashSpace;
    }

    // Actual RPM variation path mapping (idle -> rev -> idle -> rev...)
    final sampleRpms = [
      800, 
      rpms.isNotEmpty ? rpms[0] : 3200, 
      900, 
      rpms.length > 1 ? rpms[1] : 3418, 
      850, 
      rpms.length > 2 ? rpms[2] : 3315, 
      800
    ];

    final xPositions = List.generate(sampleRpms.length, (i) {
      return 24.0 + (w - 24.0) * (i / (sampleRpms.length - 1));
    });

    final actualPoints = <Offset>[];
    for (int i = 0; i < sampleRpms.length; i++) {
      double val = sampleRpms[i].toDouble();
      if (val < 0) val = 0;
      if (val > 4000) val = 4000;
      final y = graphHeight * (1.0 - (val / 4000.0));
      actualPoints.add(Offset(xPositions[i], y));
    }

    // Draw grid labels for points
    final labels = ['Idle', 'Snap 1', 'Idle', 'Snap 2', 'Idle', 'Snap 3', 'Idle'];
    for (int i = 0; i < xPositions.length; i++) {
      if (i % 2 != 0 || i == 0 || i == xPositions.length - 1) {
        textPainter.text = TextSpan(
          text: labels[i],
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 8.sp,
            fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(xPositions[i] - textPainter.width / 2, graphHeight + 4.h));
      }
    }

    // Draw Smooth Curve for Actual
    if (actualPoints.isNotEmpty) {
      final actualPath = Path()..moveTo(actualPoints.first.dx, actualPoints.first.dy);
      
      for (int i = 0; i < actualPoints.length - 1; i++) {
        final p0 = actualPoints[i];
        final p1 = actualPoints[i + 1];
        final controlX = p0.dx + (p1.dx - p0.dx) / 2;
        actualPath.cubicTo(
          controlX, p0.dy,
          controlX, p1.dy,
          p1.dx, p1.dy,
        );
      }

      final actualPaint = Paint()
        ..color = Colors.red.shade400
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      
      canvas.drawPath(actualPath, actualPaint);

      // Draw peaks dots and labels
      final peakPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      final peakStroke = Paint()
        ..color = Colors.red.shade400
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;

      final snapIndices = [1, 3, 5];
      for (int idx in snapIndices) {
        final pt = actualPoints[idx];
        canvas.drawCircle(pt, 3.5, peakPaint);
        canvas.drawCircle(pt, 3.5, peakStroke);

        // Peak RPM value label
        textPainter.text = TextSpan(
          text: sampleRpms[idx].toString(),
          style: TextStyle(
            color: Colors.red.shade600,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(pt.dx - textPainter.width / 2, pt.dy - 14.h));
      }
    }
  }

  @override
  bool shouldRepaint(covariant RpmVariationsChartPainter oldDelegate) {
    return oldDelegate.rpms != rpms;
  }
}
