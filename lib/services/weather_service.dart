import 'package:dvt_interview/models/current_weather.dart';
import 'package:dvt_interview/services/api_service.dart';

class WeatherService {
  final String weatherAPIKey='YOUR_API_KEY';
  Future<CurrentWeather> getCurrentWeather({required double lat, required double lon}) async{
    final response = await APIService('https://api.openweathermap.org/data/2.5')
        .get('/weather', {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': weatherAPIKey,
      'units': 'metric',
    });
    return CurrentWeather.fromJson(response);

  }
}
