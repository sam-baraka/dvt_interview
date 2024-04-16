import 'package:dvt_interview/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:dvt_interview/routes/router.dart';
import 'package:dvt_interview/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentWeatherCubit(WeatherService())
        ..getCurrentWeather(lat: 0.0, lon: 0.0),
      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    );
  }
}
