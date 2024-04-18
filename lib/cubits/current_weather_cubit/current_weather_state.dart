part of 'current_weather_cubit.dart';

sealed class CurrentWeatherState {}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}

class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeather currentWeather;
  final List<DailyForecastResponse> previousForecastDays;

  CurrentWeatherLoaded(
      {required this.currentWeather, required this.previousForecastDays});
}

class CurrentWeatherError extends CurrentWeatherState {
  final String message;

  CurrentWeatherError(this.message);
}
