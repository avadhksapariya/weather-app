import 'package:flutter/material.dart';

class OtherInfoCard extends StatelessWidget {
  const OtherInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28,),
        const SizedBox(
          height: 8,
        ),
        Text(label),
        const SizedBox(
          height: 8,
        ),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      ],
    );
  }
}