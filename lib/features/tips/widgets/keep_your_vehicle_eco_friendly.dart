import 'package:flutter/material.dart';

class KeepYourVehicleEcoFriendly extends StatelessWidget {
  const KeepYourVehicleEcoFriendly({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Keep your Vehicle Eco-Friendly",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5A805E),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 25),
        Column(
          children: const [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _EcoFriendlyCard(
                    title: "Regular engine \nservicing",
                    subtitle: "View your past scan\nreport and results",
                    imagePath: "assets/images/tips/EngineServing.png",
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: _EcoFriendlyCard(
                    title: "Check fuel\nquality",
                    subtitle: "View your past scan\nreport and results",
                    imagePath: "assets/images/tips/FuelQuality.png",
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _EcoFriendlyCard(
                    title: "Maintain tire\npressure",
                    subtitle: "Proper pressure\nsaves fuel and\nincreases safety",
                    imagePath: "assets/images/tips/Pressure.png",
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: _EcoFriendlyCard(
                    title: "Replace old\nfilters",
                    subtitle: "Clean filters improve\nair quality and\nengine efficiency",
                    imagePath: "assets/images/tips/OldFilters.png",
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _EcoFriendlyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const _EcoFriendlyCard({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image Container
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8EE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 6),
        // Text Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
