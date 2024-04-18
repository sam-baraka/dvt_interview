import 'package:dvt_interview/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:dvt_interview/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CurrentWeatherCubit, CurrentWeatherState>(
          builder: (context, state) {
        if (state is CurrentWeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CurrentWeatherLoaded) {
          return Scaffold(
            backgroundColor: AppColors.cloudy,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/forest_cloudy.png',
                        fit: BoxFit.cover,
                        height: 400,
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        bottom: 16,
                        left: 16,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${state.currentWeather.temp}°C',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 28),
                              ),
                              Text(
                                state.currentWeather.description.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        state.currentWeather.tempMin,
                        state.currentWeather.temp,
                        state.currentWeather.tempMax
                      ]
                          .map((e) => Text(
                                '$e°C',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))
                          .toList()),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['Min', 'Current', 'Max']
                          .map((e) => Text(
                                e.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ))
                          .toList()),
                  Expanded(
                      child: ListView(
                    children: state.previousForecastDays
                        .map((e) => Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        DateFormat('EEEE')
                                            .format(DateTime.parse(e.dtTxt)),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      'assets/icons/rain.png',
                                      height: 40,
                                    ),
                                    const Spacer(),
                                    Text('${e.main.temp}°C',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ],
                                )

                            // ListTile(
                            //       title: Text(DateFormat('EEEE, d ')
                            //           .format(DateTime.parse(e.dtTxt))),
                            //       subtitle: Text('${e.main.temp}°C'),
                            //     )

                            )
                        .toList(),
                  ))
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }, listener: (context, state) {
        if (state is CurrentWeatherError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      }),
    );
  }
}
