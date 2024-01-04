import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/customs/custom_weather_card.dart';
import 'package:weather_app/secrets.dart';

import 'customs/custom_info_card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late double temp;

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

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
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];

          return Padding(
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text('$currentTemp °K', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              Icon(currentSky == 'Clouds' || currentSky == 'Rain' ? Icons.cloud : Icons.sunny, size: 64,),
                              const SizedBox(height: 10,),
                              Text(currentSky, style: const TextStyle(fontSize: 24),),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OtherInfoCard(icon: Icons.water_drop, label: 'Humidity', value: currentHumidity.toString(),),
                    OtherInfoCard(icon: Icons.air, label: 'Wind Speed', value: currentWindSpeed.toString(),),
                    OtherInfoCard(icon: Icons.beach_access, label: 'Pressure', value: currentPressure.toString(),),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String,dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Rajkot';
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey'),
      );

      final data = jsonDecode(response.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred.';
      }

      return data;

    } catch (e) {
      throw e.toString();
    }
  }
}

