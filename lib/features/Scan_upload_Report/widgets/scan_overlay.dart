import 'package:flutter/material.dart';

class ScanOverlay extends StatelessWidget {
  final double frameWidth;
  final double frameHeight;
  final Color overlayColor;

  const ScanOverlay({
    super.key,
    required this.frameWidth,
    required this.frameHeight,
    this.overlayColor = const Color(0x8C000000), // ~55% black
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: ScanOverlayPainter(
        frameWidth: frameWidth,
        frameHeight: frameHeight,
        overlayColor: overlayColor,
      ),
    );
  }
}

class ScanOverlayPainter extends CustomPainter {
  final double frameWidth;
  final double frameHeight;
  final Color overlayColor;

  ScanOverlayPainter({
    required this.frameWidth,
    required this.frameHeight,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final cutoutRect = Rect.fromCenter(
      center: center,
      width: frameWidth,
      height: frameHeight,
    );

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(cutoutRect, const Radius.circular(8)),
      );
    path.fillType = PathFillType.evenOdd;

    final paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ScanOverlayPainter oldDelegate) {
    return oldDelegate.frameWidth != frameWidth ||
        oldDelegate.frameHeight != frameHeight ||
        oldDelegate.overlayColor != overlayColor;
  }
}

