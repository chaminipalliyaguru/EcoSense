import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreviewOverlay extends StatefulWidget {
  final File imageFile;
  final VoidCallback onConfirm;
  final VoidCallback onRetake;
  final Color primaryColor;
  final Animation<double> scanAnimation;

  const ImagePreviewOverlay({
    super.key,
    required this.imageFile,
    required this.onConfirm,
    required this.onRetake,
    required this.primaryColor,
    required this.scanAnimation,
  });

  @override
  State<ImagePreviewOverlay> createState() => _ImagePreviewOverlayState();
}

class _ImagePreviewOverlayState extends State<ImagePreviewOverlay> {
  int _rotationTurns = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // ── 1. The Photo (Full screen with padding, fit contain) ──
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 100),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: _rotationTurns,
                    child: Image.file(
                      widget.imageFile,
                      fit: BoxFit.contain, // Ensures the full image is visible without cropping
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── 2. Top Title and Rotate Button ──
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48), // Balance for centering title
                const Text(
                  'Verify Report Quality',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.rotate_90_degrees_cw, color: Colors.white, size: 28),
                  onPressed: () {
                    setState(() {
                      _rotationTurns = (_rotationTurns + 1) % 4;
                    });
                  },
                ),
              ],
            ),
          ),

          // ── 3. Bottom Action Buttons ──
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  // Retake Button
                  Expanded(
                    child: _buildButton(
                      label: 'Retake',
                      onPressed: widget.onRetake,
                      isOutlined: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // OK Button
                  Expanded(
                    child: _buildButton(
                      label: 'OK',
                      onPressed: widget.onConfirm,
                      isOutlined: false,
                      color: widget.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    bool isOutlined = false,
    Color? color,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          if (!isOutlined)
            BoxShadow(
              color: (color ?? Colors.black).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
    );
  }
}
