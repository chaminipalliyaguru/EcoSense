import 'package:flutter/material.dart';

class QuickTipsSection extends StatelessWidget {
  final Color primaryGreen;
  final bool isGuest;

  const QuickTipsSection({
    super.key,
    required this.primaryGreen,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quick Tips',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/tips',
                    arguments: isGuest,
                  );
                },
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _QuickTipItem(
                icon: Icons.build_outlined,
                label: 'Regular\nMaintenance',
                detail:
                    'Service your vehicle\nregularly for better\nperformance',
                primaryGreen: primaryGreen,
              ),
              _QuickTipItem(
                icon: Icons.eco_outlined,
                label: 'Check\nEmissions',
                detail:
                    'Keep your emissions\nin check for cleaner\nenvironment',
                primaryGreen: primaryGreen,
              ),
              _QuickTipItem(
                icon: Icons.speed_outlined,
                label: 'Drive\nSmart',
                detail:
                    'Avoid idling and drive\nsmoothly to reduce\nemissions',
                primaryGreen: primaryGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickTipItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;
  final Color primaryGreen;

  const _QuickTipItem({
    required this.icon,
    required this.label,
    required this.detail,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: primaryGreen, size: 36),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
