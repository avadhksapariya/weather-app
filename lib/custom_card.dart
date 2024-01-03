import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({super.key});

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
        child: const Column(
          children: [
            Text('09:00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 8,
            ),
            Icon(Icons.cloud, size: 28,),
            SizedBox(
              height: 8,
            ),
            Text('301.07 °K'),
          ],
        ),
      ),
    );
  }
}