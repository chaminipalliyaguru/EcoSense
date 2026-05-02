import 'package:flutter/material.dart';

class ScanFrame extends StatelessWidget {
  final double width;
  final double height;
  final Animation<double>? scanAnimation;
  final Color cornerColor;
  final String hintText;
  final bool showScanLine;

  const ScanFrame({
    super.key,
    required this.width,
    required this.height,
    this.scanAnimation,
    required this.cornerColor,
    required this.hintText,
    this.showScanLine = false,
  });

  @override
  Widget build(BuildContext context) {
    const cornerSize = 22.0;
    const cornerThick = 2.5;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // Transparent frame interior
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
          ),

          // Animated scan line (conditional)
          if (showScanLine && scanAnimation != null)
            AnimatedBuilder(
              animation: scanAnimation!,
              builder: (_, __) => Positioned(
                top: scanAnimation!.value * (height - 4),
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        cornerColor.withValues(alpha: 0.8),
                        cornerColor,
                        cornerColor.withValues(alpha: 0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Corners
          _PositionedCorner(top: true, left: true, size: cornerSize, thick: cornerThick, color: cornerColor),
          _PositionedCorner(top: true, left: false, size: cornerSize, thick: cornerThick, color: cornerColor),
          _PositionedCorner(bottom: true, left: true, size: cornerSize, thick: cornerThick, color: cornerColor),
          _PositionedCorner(bottom: true, left: false, size: cornerSize, thick: cornerThick, color: cornerColor),

          // Hint text
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              hintText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PositionedCorner extends StatelessWidget {
  final bool top;
  final bool left;
  final bool bottom;
  final double size;
  final double thick;
  final Color color;

  const _PositionedCorner({
    this.top = false,
    this.left = false,
    this.bottom = false,
    required this.size,
    required this.thick,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top ? 0 : null,
      bottom: bottom ? 0 : null,
      left: left ? 0 : null,
      right: !left ? 0 : null,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _CornerPainter(
            top: top,
            left: left,
            color: color,
            thickness: thick,
          ),
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final bool top;
  final bool left;
  final Color color;
  final double thickness;

  const _CornerPainter({
    required this.top,
    required this.left,
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final cx = left ? 0.0 : size.width;
    final cy = top ? 0.0 : size.height;
    final hx = left ? size.width : 0.0;
    final vy = top ? size.height : 0.0;

    canvas.drawLine(Offset(cx, cy), Offset(hx, cy), paint);
    canvas.drawLine(Offset(cx, cy), Offset(cx, vy), paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) =>
      old.color != color || old.thickness != thickness;
}
