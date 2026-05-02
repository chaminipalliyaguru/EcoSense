import 'package:flutter/material.dart';

class ScanOverlay extends StatelessWidget {
  final double frameWidth;
  final double frameHeight;

  const ScanOverlay({
    super.key,
    required this.frameWidth,
    required this.frameHeight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = constraints.maxWidth;
        final screenH = constraints.maxHeight;
        
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.55),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  width: frameWidth,
                  height: frameHeight,
                  decoration: BoxDecoration(
                    color: Colors.black, // This color doesn't matter, it's the shape that cuts
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
