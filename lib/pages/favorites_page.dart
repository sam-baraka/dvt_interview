import 'package:dvt_interview/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:dvt_interview/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder(
        future: HiveFavoritesService().getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      context.read<CurrentWeatherCubit>().getCurrentWeather(
                          lat: snapshot.data![index]['lat'],
                          lon: snapshot.data![index]['lon']);
                    },
                    title: Text(snapshot.data![index]['name']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        HiveFavoritesService()
                            .removeFavorite(snapshot.data![index]);
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No favorites yet'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
