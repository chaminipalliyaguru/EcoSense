import 'package:flutter/material.dart';

class HowToDoIt extends StatelessWidget {
  const HowToDoIt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How to do it(Step by step)",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5A805E),
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 24),
        _TipStepItem(
          number: "1",
          title: "User takes photo of emission testing reports",
          description: "Capture the report using the in-app camera.",
          showLine: true,
        ),
        _TipStepItem(
          number: "2",
          title: "System processes data",
          description:
              "The system app scans and extracts the required information.",
          showLine: true,
        ),
        _TipStepItem(
          number: "3",
          title: "Model predicts emission levels",
          description: "Our intelligent model analyzes the data and predicts results.",
          showLine: true,
        ),
        _TipStepItem(
          number: "4",
          title: "Results are displayed",
          description: "You get results along with reasons and recommendations",
          showLine: false,
        ),
      ],
    );
  }
}

class _TipStepItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final bool showLine;

  const _TipStepItem({
    required this.number,
    required this.title,
    required this.description,
    required this.showLine,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column with circle and line
        SizedBox(
          width: 44,
          child: Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF5A805E),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (showLine)
                Column(
                  children: List.generate(
                    8,
                    (index) => Container(
                      width: 1.5,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: index % 2 == 0
                          ? const Color(0xFF5A805E).withOpacity(0.4)
                          : Colors.transparent,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Right column with text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
