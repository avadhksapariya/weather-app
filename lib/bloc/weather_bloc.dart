import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/model_weather.dart';
import 'package:weather_app/data/repository/repo_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final RepoWeather repoWeather;

  WeatherBloc(this.repoWeather) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeatherDetails);
  }

  void _getCurrentWeatherDetails(WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await repoWeather.getCurrentWeather(event.city);
      emit(WeatherSuccess(modelWeather: weather));
    } on Exception catch (e) {
      emit(WeatherFailure("Bloc WeatherFailure : ${e.toString()}"));
    }
  }
}
