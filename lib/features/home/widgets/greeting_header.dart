import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;
  final String subtitle;

  const GreetingHeader({
    super.key,
    required this.userName,
    this.subtitle = 'Smart care for your vehicle',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              Icons.person,
              size: 32,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName.isEmpty ? 'Hello!' : 'Hello, $userName!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
