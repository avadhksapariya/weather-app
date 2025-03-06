import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RESTWeatherData {
  final openWeatherApiKey = dotenv.get("KEY");

  Future<String?> getCurrentWeather(String city) async {
    const String tag = 'get_current_weather';

    final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openWeatherApiKey');
    log('$tag URL: GET: $url');

    try {
      final response = await http.get(url);
      log('$tag response: ${response.body}');

      return response.body;
    } catch (e) {
      log('$tag error: ${e.toString()}');
      return null;
    }
  }
}
