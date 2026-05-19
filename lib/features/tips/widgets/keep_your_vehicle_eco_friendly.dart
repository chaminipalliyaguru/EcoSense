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
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5A805E),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 30),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
          childAspectRatio: 1.8,
          children: const [
            _EcoFriendlyCard(
              title: "Regular engine servicing",
              subtitle: "View your past scan\nreport and results",
              imagePath: "assets/images/tips/EngineServing.png",
            ),
            _EcoFriendlyCard(
              title: "Check fuel\nquality",
              subtitle: "View your past scan\nreport and results",
              imagePath: "assets/images/tips/FuelQuality.png",
            ),
            _EcoFriendlyCard(
              title: "Maintain tire\npressure",
              subtitle: "Proper pressure\nsaves fuel and\nincreases safety",
              imagePath: "assets/images/tips/Pressure.png",
            ),
            _EcoFriendlyCard(
              title: "Replace old\nfilters",
              subtitle: "Clean filters improve\nair quality and\nengine efficiency",
              imagePath: "assets/images/tips/OldFilters.png",
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(width: 12),
        // Text Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
