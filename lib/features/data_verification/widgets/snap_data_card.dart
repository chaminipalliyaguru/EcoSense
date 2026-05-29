import 'package:flutter/material.dart';

class SnapDataCard extends StatelessWidget {
  final String title;

  const SnapDataCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final data = [12.5, 14.1, 11.9];
    final avg = data.reduce((a, b) => a + b) / data.length;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const Row(
                  children: [
                    Icon(Icons.bar_chart, color: Colors.pink, size: 18),
                    SizedBox(width: 4),
                    Text("Live Extraction",
                        style: TextStyle(color: Colors.pink)),
                  ],
                )
              ],
            ),

            const SizedBox(height: 16),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Snap #"),
                Text("Opacity (%)"),
              ],
            ),

            const SizedBox(height: 12),

            ...List.generate(data.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(child: Text("${index + 1}")),
                    Expanded(
                      child: TextFormField(
                        initialValue: data[index].toString(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("AVERAGE",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(avg.toStringAsFixed(2),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            )
          ],
        ),
      ),
    );
  }
}