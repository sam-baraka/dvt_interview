import 'package:dvt_interview/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:dvt_interview/cubits/location_cubit/location_state.dart';
import 'package:dvt_interview/routes/router.dart';
import 'package:dvt_interview/services/location_service.dart';
import 'package:dvt_interview/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'cubits/location_cubit/location_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LocationCubit(
                locationService: LocationService(location: Location()))
              ..getLocation()),
        BlocProvider(
          create: (context) => CurrentWeatherCubit(WeatherService()),
        ),
      ],
      child: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is LocationLoaded) {
            context
                .read<CurrentWeatherCubit>()
                .getCurrentWeather(lat: state.lat, lon: state.lon);
          }
        },
        builder: (context, state) {
          if (state is LocationLoaded) {
            return MaterialApp.router(
              routerConfig: appRouter,
            );
          } else if (state is LocationError) {
            return MaterialApp(
                home: Scaffold(
              body: Center(
                child: Text(state.message),
              ),
            ));
          } else {
            return const MaterialApp(
                home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
          }
        },
      ),
    );
  }
}
