import 'package:flutter/material.dart';

class TipsHeader extends StatelessWidget {
  const TipsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tips & Guide",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Follow these simple tips and steps to get things done easily",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        // Bulb Image Asset
        SizedBox(
          width: 80,
          height: 80,
          child: Image.asset(
            'assets/images/tips/bulb.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
