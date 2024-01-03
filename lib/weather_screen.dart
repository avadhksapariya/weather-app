import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/customs/custom_weather_card.dart';

import 'customs/custom_info_card.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('300.67 °K', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Icon(Icons.cloud, size: 64,),
                          SizedBox(height: 10,),
                          Text('Rain', style: TextStyle(fontSize: 24),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // card row
            const Text('Weather Forecast', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 6,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastCard(time: '09:00', icon: Icons.cloud, temperature: '301.17 °K',),
                  HourlyForecastCard(time: '12:00', icon: Icons.cloud, temperature: '301.54 °K',),
                  HourlyForecastCard(time: '15:00', icon: Icons.cloud, temperature: '301.11 °K',),
                  HourlyForecastCard(time: '18:00', icon: Icons.cloud, temperature: '300.79 °K',),
                  HourlyForecastCard(time: '21:00', icon: Icons.cloud, temperature: '300.23 °K',),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // misc. info.
            const Text('Additional Information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 6,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OtherInfoCard(icon: Icons.water_drop, label: 'Humidity', value: '97',),
                OtherInfoCard(icon: Icons.air, label: 'Wind Speed', value: '7.67'),
                OtherInfoCard(icon: Icons.beach_access, label: 'Pressure', value: '1006'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

