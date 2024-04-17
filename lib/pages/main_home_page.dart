import 'package:dvt_interview/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentWeatherCubit, CurrentWeatherState>(
        builder: (context, state) {
      if (state is CurrentWeatherLoading) {
        return const CircularProgressIndicator();
      } else if (state is CurrentWeatherLoaded) {
        return Column(
          children: [
            Text(state.currentWeather.city),
            Text(state.currentWeather.clouds.toString()),
            Text(state.currentWeather.description),
          ],
        );
      } else {
        return Container();
      }
    }, listener: (context, state) {
      if (state is CurrentWeatherError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    });
  }
}
