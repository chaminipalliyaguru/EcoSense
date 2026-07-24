import 'package:flutter/material.dart';

class ResultInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const ResultInfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    IconData getIconForTitle(String title) {
      final t = title.toLowerCase();
      if (t.contains('summary')) return Icons.article_rounded;
      if (t.contains('reasons')) return Icons.rule_rounded;
      if (t.contains('recommendations')) return Icons.tips_and_updates_rounded;
      if (t.contains('causes')) return Icons.search_rounded;
      if (t.contains('repair') || t.contains('steps')) return Icons.build_rounded;
      if (t.contains('drive')) return Icons.directions_car_rounded;
      if (t.contains('prevent')) return Icons.shield_rounded;
      return Icons.info_outline_rounded;
    }

    final Color primaryGreen = const Color(0xFF5A805E);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade100, width: 1.5),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  getIconForTitle(title),
                  color: primaryGreen,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen.withOpacity(0.9),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
