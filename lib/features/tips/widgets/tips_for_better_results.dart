import 'package:flutter/material.dart';

class TipsForBetterResults extends StatelessWidget {
  const TipsForBetterResults({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tips for better results",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5A805E),
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 20),
        _CheckmarkItem(text: "Ensure good lighting when scanning"),
        _CheckmarkItem(text: "Keep the report flat and clear"),
        _CheckmarkItem(text: "Avoid blurry images"),
        _CheckmarkItem(text: "Upload full report (no cropped edges)"),
      ],
    );
  }
}

class _CheckmarkItem extends StatelessWidget {
  final String text;

  const _CheckmarkItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Custom Checkmark Icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF32B593),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.check,
              size: 18,
              color: Color(0xFF32B593),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
