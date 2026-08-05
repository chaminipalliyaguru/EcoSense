import 'package:flutter/material.dart';

class ResultStatusIndicator extends StatelessWidget {
  final String status; // "PASS" or "FAIL"
  final bool isPass;

  const ResultStatusIndicator({
    super.key,
    required this.status,
    required this.isPass,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPass ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    final bgColor = isPass ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
    final icon = isPass ? Icons.check_circle_rounded : Icons.cancel_rounded;
    final title = isPass ? 'Emission Test Passed' : 'Emission Test Failed';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 64,
          ),
          const SizedBox(height: 12),
          Text(
            status,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
