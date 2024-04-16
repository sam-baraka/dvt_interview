import 'package:dvt_interview/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:dvt_interview/cubits/location_cubit/location_cubit.dart';
import 'package:dvt_interview/cubits/location_cubit/location_state.dart';
import 'package:dvt_interview/resources/app_colors.dart';
import 'package:dvt_interview/services/hive_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:intl/intl.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
              color: Colors.purple,
              onPressed: () {
                context.go('/favorites');
              },
              child: const Text('View Favorites')),
          const SizedBox(height: 16),
          BlocConsumer<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state is LocationError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is LocationLoaded) {
                return CupertinoButton(
                  color: Colors.purple,
                  child: const Text('Mark As Favorite'),
                  onPressed: () {
                    HiveFavoritesService().addFavorite({
                      'lat': state.lat,
                      'lon': state.lon,
                      'name': state.name
                    });
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(height: 16),
          CupertinoButton(
              color: Colors.purple,
              child: const Text('Search Other Locations'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlocConsumer<LocationCubit, LocationState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is LocationLoaded) {
                          return GoogleMapLocationPicker(
                            currentLatLng: LatLng(state.lat, state.lon),
                            apiKey: "AIzaSyD-vw60TZXSTh-L0P17zxajnhOzbVCyCco",
                            onNext: (GeocodingResult? result) {
                              context.read<LocationCubit>().setLocation(
                                  result!.geometry.location.lat,
                                  result.geometry.location.lng,
                                  result.formattedAddress!);
                              context
                                  .read<CurrentWeatherCubit>()
                                  .getCurrentWeather(
                                      lat: result.geometry.location.lat,
                                      lon: result.geometry.location.lng);
                              Navigator.of(context).pop();
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
      body: BlocConsumer<CurrentWeatherCubit, CurrentWeatherState>(
          builder: (context, state) {
        if (state is CurrentWeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CurrentWeatherLoaded) {
          return Scaffold(
            backgroundColor: getWeatherType(state.currentWeather.description) ==
                    'sunny'
                ? AppColors.sunny
                : getWeatherType(state.currentWeather.description) == 'rainy'
                    ? AppColors.rainy
                    : AppColors.cloudy,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        getWeatherType(state.currentWeather.description) ==
                                'sunny'
                            ? 'assets/images/forest_sunny.png'
                            : getWeatherType(
                                        state.currentWeather.description) ==
                                    'rainy'
                                ? 'assets/images/forest_rainy.png'
                                : 'assets/images/forest_cloudy.png',
                        fit: BoxFit.fitWidth,
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
                              Text(state.currentWeather.city,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24)),
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
                        .map((e) => InkWell(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
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
                                      getWeatherType(state.currentWeather
                                                  .description) ==
                                              'sunny'
                                          ? 'assets/icons/clear.png'
                                          : getWeatherType(state.currentWeather
                                                      .description) ==
                                                  'rainy'
                                              ? 'assets/icons/rain.png'
                                              : 'assets/icons/partlysunny.png',
                                      height: 40,
                                    ),
                                    const Spacer(),
                                    Text('${e.main.temp}°C',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ],
                                ),
                              ),
                            ))
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

getWeatherType(String input) {
  if (input.contains('cloud')) {
    return 'cloudy';
  }
  if (input.contains('rain')) {
    return 'rainy';
  }
  if (input.contains('clear')) {
    return 'sunny';
  }
}
