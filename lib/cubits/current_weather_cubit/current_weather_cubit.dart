import 'package:dvt_interview/models/current_weather.dart';
import 'package:dvt_interview/models/daily_forecast_response.dart';
import 'package:dvt_interview/services/weather_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  final WeatherService _weatherService;

  CurrentWeatherCubit(this._weatherService) : super(CurrentWeatherInitial());

  Future<void> getCurrentWeather(
      {required double lat, required double lon}) async {
    emit(CurrentWeatherLoading());
    try {
      final currentWeather =
          await _weatherService.getCurrentWeather(lat: lat, lon: lon);
      final previousForecastDays =
          await _weatherService.getPreviousForecastDays(lat: lat, lon: lon);
      emit(CurrentWeatherLoaded(currentWeather:currentWeather, previousForecastDays: previousForecastDays));
    } catch (e) {
      emit(CurrentWeatherError(e.toString()));
    }
  }
}
