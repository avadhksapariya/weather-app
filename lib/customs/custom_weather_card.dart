import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({super.key, required this.time, required this.icon, required this.temperature});

  final String time;
  final IconData icon;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(time, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(
              height: 8,
            ),
            Icon(icon, size: 28,),
            const SizedBox(
              height: 8,
            ),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}