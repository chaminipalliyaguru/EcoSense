import 'package:flutter/material.dart';

class GuestFeatureList extends StatelessWidget {
  const GuestFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _FullWidthFeatureCard(
            icon: Icons.lightbulb_outline,
            iconColor: Colors.orange,
            iconBg: Colors.orange.shade50,
            title: 'Tips & How To',
            subtitle:
                'Helpful tips and guides to keep your vehicle in\ngood condition',
            onTap: () {
              Navigator.pushNamed(
                context,
                '/tips',
                arguments: true,
              );
            },
          ),
          const SizedBox(height: 12),
          _FullWidthFeatureCard(
            icon: Icons.info_outline,
            iconColor: Colors.blue,
            iconBg: Colors.blue.shade50,
            title: 'About',
            subtitle: 'Learn more about the app and our mission',
            onTap: () {
              // TODO: Navigate to About
            },
          ),
          const SizedBox(height: 12),
          _FullWidthFeatureCard(
            icon: Icons.support_agent,
            iconColor: Colors.purple,
            iconBg: Colors.purple.shade50,
            title: 'Help and Support',
            subtitle: 'Need help? Contact our support team',
            onTap: () {
              // TODO: Navigate to Support
            },
          ),
        ],
      ),
    );
  }
}

class _FullWidthFeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FullWidthFeatureCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
