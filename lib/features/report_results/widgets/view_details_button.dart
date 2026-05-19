import 'package:flutter/material.dart';

class ViewDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ViewDetailsButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF5A805E),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Text(
          'View Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
