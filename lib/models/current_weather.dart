class CurrentWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final double rainVolume;
  final int clouds;
  final int visibility;
  final String description;
  final String icon;
  final String city;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime time;

  CurrentWeather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.rainVolume,
    required this.clouds,
    required this.visibility,
    required this.description,
    required this.icon,
    required this.city,
    required this.sunrise,
    required this.sunset,
    required this.time,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final wind = json['wind'];
    final rain = json['rain'];
    final clouds = json['clouds'];
    final weather = json['weather'][0];
    final sys = json['sys'];

    return CurrentWeather(
      temp: main['temp'].toDouble(),
      feelsLike: main['feels_like'].toDouble(),
      tempMin: main['temp_min'].toDouble(),
      tempMax: main['temp_max'].toDouble(),
      pressure: main['pressure'],
      humidity: main['humidity'],
      windSpeed: wind['speed'].toDouble(),
      windDeg: wind['deg'],
      rainVolume: rain != null ? rain['1h'].toDouble() : 0.0,
      clouds: clouds['all'],
      visibility: json['visibility'],
      description: weather['description'],
      icon: weather['icon'],
      city: json['name'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(sys['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(sys['sunset'] * 1000),
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  static toJson(CurrentWeather currentWeather) {
    return {
      'temp': currentWeather.temp,
      'feelsLike': currentWeather.feelsLike,
      'tempMin': currentWeather.tempMin,
      'tempMax': currentWeather.tempMax,
      'pressure': currentWeather.pressure,
      'humidity': currentWeather.humidity,
      'windSpeed': currentWeather.windSpeed,
      'windDeg': currentWeather.windDeg,
      'rainVolume': currentWeather.rainVolume,
      'clouds': currentWeather.clouds,
      'visibility': currentWeather.visibility,
      'description': currentWeather.description,
      'icon': currentWeather.icon,
      'city': currentWeather.city,
      'sunrise': currentWeather.sunrise.millisecondsSinceEpoch,
      'sunset': currentWeather.sunset.millisecondsSinceEpoch,
      'time': currentWeather.time.millisecondsSinceEpoch,
    };
  }
}
