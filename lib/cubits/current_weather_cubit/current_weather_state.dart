part of 'current_weather_cubit.dart';

sealed class CurrentWeatherState {}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}

class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeather currentWeather;

  CurrentWeatherLoaded(this.currentWeather);
}

class CurrentWeatherError extends CurrentWeatherState {
  final String message;

  CurrentWeatherError(this.message);
}
