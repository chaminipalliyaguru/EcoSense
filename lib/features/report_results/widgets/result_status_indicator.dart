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
    if (isPass) {
      return Center(
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF8BC34A).withOpacity(0.6),
              width: 10,
            ),
          ),
          child: Center(
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Color(0xFF388E3C),
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFFFFDADA),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFF8B6B6),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Color(0xFF8B0000),
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      );
    }
  }
}
