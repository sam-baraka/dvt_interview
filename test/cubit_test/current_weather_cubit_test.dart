import 'package:bloc_test/bloc_test.dart';
import 'package:dvt_interview/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:dvt_interview/models/current_weather.dart';
import 'package:dvt_interview/services/weather_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockWeatherService extends Mock implements WeatherService {
  @override
  Future<CurrentWeather> getCurrentWeather(
      {required double lat, required double lon}) async {
    if (lat == 0.0 && lon == 0.0) {
      return CurrentWeather.fromJson(currentWeatherJson);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}

void main() {
  group('CurrentWeatherCubit', () {
    test('initial state is CurrentWeatherInitial', () {
      final cubit = CurrentWeatherCubit(MockWeatherService());
      expect(cubit.state, isA<CurrentWeatherInitial>());
    });

    blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherLoaded] when getCurrentWeather is called with valid coordinates',
      build: () => CurrentWeatherCubit(MockWeatherService()),
      act: (bloc) => bloc.getCurrentWeather(lat: 0.0, lon: 0.0),
      expect: () => <Matcher>[
        isA<CurrentWeatherLoading>(),
        isA<CurrentWeatherLoaded>().having(
          (state) => state.currentWeather,
          'currentWeather',
          isNotNull,
        ),
      ],
    );

    blocTest<CurrentWeatherCubit, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherError] when getCurrentWeather is called with invalid coordinates',
      build: () => CurrentWeatherCubit(MockWeatherService()),
      act: (bloc) => bloc.getCurrentWeather(lat: 1.0, lon: 1.0),
      expect: () => <Matcher>[
        isA<CurrentWeatherLoading>(),
        isA<CurrentWeatherError>(),
      ],
    );
  });
}

var currentWeatherJson = {
  "coord": {"lon": 10.99, "lat": 44.34},
  "weather": [
    {"id": 501, "main": "Rain", "description": "moderate rain", "icon": "10d"}
  ],
  "base": "stations",
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "pressure": 1015,
    "humidity": 64,
    "sea_level": 1015,
    "grnd_level": 933
  },
  "visibility": 10000,
  "wind": {"speed": 0.62, "deg": 349, "gust": 1.18},
  "rain": {"1h": 3.16},
  "clouds": {"all": 100},
  "dt": 1661870592,
  "sys": {
    "type": 2,
    "id": 2075663,
    "country": "IT",
    "sunrise": 1661834187,
    "sunset": 1661882248
  },
  "timezone": 7200,
  "id": 3163858,
  "name": "Zocca",
  "cod": 200
};
