import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onRetake;
  final VoidCallback onConfirm;

  const ActionButtons({
    super.key,
    required this.onRetake,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onRetake,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.green),
            ),
            child: const Text("Retake Scan",
                style: TextStyle(color: Colors.green)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Confirm & Continue"),
          ),
        ),
      ],
    );
  }
}