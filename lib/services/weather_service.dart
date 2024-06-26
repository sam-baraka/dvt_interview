import 'package:dvt_interview/models/current_weather.dart';
import 'package:dvt_interview/models/daily_forecast_response.dart';
import 'package:dvt_interview/services/api_service.dart';

class WeatherService {
  final String weatherAPIKey = 'a57efcc536864a1113f42de1d0d1903b';
  Future<CurrentWeather> getCurrentWeather(
      {required double lat, required double lon}) async {
    try {
      final response =
          await APIService('https://api.openweathermap.org/data/2.5')
              .get('/weather', {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'appid': weatherAPIKey,
        'units': 'metric',
      });
      return CurrentWeather.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DailyForecastResponse>> getPreviousForecastDays(
      {required double lat, required double lon}) async {
    try {
      final response =
          await APIService('https://api.openweathermap.org/data/2.5')
              .get('/forecast', {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'appid': weatherAPIKey,
        'units': 'metric',
        'exclude': 'current,minutely,hourly,alerts',
      });
      List<dynamic> list = response['list'];
      return list.map((e) => DailyForecastResponse.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
