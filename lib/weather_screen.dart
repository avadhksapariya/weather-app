import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                const Text('Hourly Forecast', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 6,
                ),
                /*SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                      HourlyForecastCard(
                        time: data['list'][i+1]['dt'].toString(),
                        icon: data['list'][i+1]['weather'][0]['main'] == 'Cloud' || data['list'][i+1]['weather'][0]['main'] == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: data['list'][i+1]['main']['temp'].toString(),
                      ),
                    ],
                  ),
                ),*/
                // this loads all the elements instantly which cause too load to an app.
                // therefore ListView Builder is used to make it lazy loading as it get scrolled to make it optimized.
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index+1];
                      final hourlySky = hourlyForecast['weather'][0]['main'];
                      final hourlyTemp = hourlyForecast['main']['temp'].toString();
                      final hourlyTime = DateTime.parse(hourlyForecast['dt_txt']);
                      return HourlyForecastCard(
                          time: DateFormat.jm().format(hourlyTime),
                          icon: hourlySky == 'Cloud' || hourlySky == 'Rain' ? Icons.cloud : Icons.sunny,
                          temperature: hourlyTemp,
                      );
                    }
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

