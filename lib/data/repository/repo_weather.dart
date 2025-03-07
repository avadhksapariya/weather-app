import 'dart:convert';
import 'dart:developer';

import 'package:weather_app/data/data_provider/rest_weather_data.dart';
import 'package:weather_app/data/models/model_weather.dart';

class RepoWeather {
  final RESTWeatherData restWeatherData;

  RepoWeather(this.restWeatherData);

  Future<ModelWeather?> getCurrentWeather() async {
    const String tag = 'repo_get_current_weather';
    ModelWeather? data;
    try {
      const city = 'Rajkot';
      final weatherData = await restWeatherData.getCurrentWeather(city);

      final decodedResult = jsonDecode(weatherData!);
      data = ModelWeather.fromJson(decodedResult);

      if (data.cod == '200') {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      log('$tag error: ${e.toString()}');
      return null;
    }
  }
}
