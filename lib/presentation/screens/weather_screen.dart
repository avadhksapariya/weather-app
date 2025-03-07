import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/customs/custom_info_card.dart';
import 'package:weather_app/presentation/widgets/customs/custom_weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(WeatherFetched());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is WeatherSuccess) {
            final data = state.modelWeather;

            if (data != null) {
              final currentTemp = data.list![0].main!.temp;
              final currentSky = data.list![0].weather![0].main;
              final currentPressure = data.list![0].main!.pressure;
              final currentWindSpeed = data.list![0].wind!.speed;
              final currentHumidity = data.list![0].main!.humidity;

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
                                  Text(
                                    '$currentTemp °K',
                                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    currentSky == 'Clouds' || currentSky == 'Rain' ? Icons.cloud : Icons.sunny,
                                    size: 64,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    currentSky!,
                                    style: const TextStyle(fontSize: 24),
                                  ),
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
                    const Text(
                      'Hourly Forecast',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
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
                            final hourlyForecast = data.list![index + 1];
                            final hourlySky = hourlyForecast.weather![0].main;
                            final hourlyTemp = hourlyForecast.main!.temp.toString();
                            final hourlyTime = DateTime.parse(hourlyForecast.dtTxt!);
                            return HourlyForecastCard(
                              time: DateFormat.jm().format(hourlyTime),
                              icon: hourlySky == 'Cloud' || hourlySky == 'Rain' ? Icons.cloud : Icons.sunny,
                              temperature: hourlyTemp,
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // misc. info.
                    const Text(
                      'Additional Information',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OtherInfoCard(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: currentHumidity.toString(),
                        ),
                        OtherInfoCard(
                          icon: Icons.air,
                          label: 'Wind Speed',
                          value: currentWindSpeed.toString(),
                        ),
                        OtherInfoCard(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: currentPressure.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Could not found the data.'));
            }
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}
