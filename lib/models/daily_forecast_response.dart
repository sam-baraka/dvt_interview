var value = {
  "dt": 1713366000,
  "main": {
    "temp": 286.29,
    "feels_like": 284.86,
    "temp_min": 286.29,
    "temp_max": 287.24,
    "pressure": 1004,
    "sea_level": 1004,
    "grnd_level": 936,
    "humidity": 46,
    "temp_kf": -0.95
  },
  "weather": [
    {"id": 500, "main": "Rain", "description": "light rain", "icon": "10d"}
  ],
  "clouds": {"all": 51},
  "wind": {"speed": 2.34, "deg": 312, "gust": 3.12},
  "visibility": 10000,
  "pop": 0.6,
  "rain": {"3h": 0.51},
  "sys": {"pod": "d"},
  "dt_txt": "2024-04-17 15:00:00"
};

class DailyForecastResponse {
  final int dt;
  final Main main;
  final int visibility;
  final double pop;
  final String dtTxt;

  DailyForecastResponse(
      {required this.dt,
      required this.main,
      required this.visibility,
      required this.pop,
      required this.dtTxt});

  factory DailyForecastResponse.fromJson(Map<String, dynamic> json) {
    return DailyForecastResponse(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      dtTxt: json['dt_txt'],
    );
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.seaLevel,
      required this.grndLevel,
      required this.humidity,
      required this.tempKf});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }
}
