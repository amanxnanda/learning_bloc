import 'dart:convert';

enum WeatherState { snow, sleet, hail, thunderstorm, heavyRain, lightRain, showers, heavyCloud, lightCloud, clear, unknown }

enum WindDirectionCompass { north, northEast, east, southEast, south, southWest, west, northWest, unknown }

extension on WeatherState {
  String get text {
    switch (this) {
      case WeatherState.snow:
        return 'sn';
      case WeatherState.sleet:
        return 'sl';
      case WeatherState.hail:
        return 'h';
      case WeatherState.thunderstorm:
        return 't';
      case WeatherState.heavyRain:
        return 'hr';
      case WeatherState.lightRain:
        return 'lr';
      case WeatherState.showers:
        return 's';
      case WeatherState.heavyCloud:
        return 'hc';
      case WeatherState.lightCloud:
        return 'lc';
      case WeatherState.clear:
        return 'c';
      case WeatherState.unknown:
        return 'u';
    }
  }
}

extension on WindDirectionCompass {
  String get text {
    switch (this) {
      case WindDirectionCompass.north:
        return 'N';
      case WindDirectionCompass.northEast:
        return 'NE';
      case WindDirectionCompass.east:
        return 'E';
      case WindDirectionCompass.southEast:
        return 'SE';
      case WindDirectionCompass.south:
        return 'S';
      case WindDirectionCompass.southWest:
        return 'SW';
      case WindDirectionCompass.west:
        return 'W';
      case WindDirectionCompass.northWest:
        return 'NW';
      case WindDirectionCompass.unknown:
        return 'U';
    }
  }
}

class Weather {
  const Weather({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.windDirectionCompass,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  final int id;
  final String weatherStateName;
  final WeatherState weatherStateAbbr;
  final WindDirectionCompass windDirectionCompass;
  final DateTime created;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final int predictability;

  Weather copyWith({
    int? id,
    String? weatherStateName,
    WeatherState? weatherStateAbbr,
    WindDirectionCompass? windDirectionCompass,
    DateTime? created,
    DateTime? applicableDate,
    double? minTemp,
    double? maxTemp,
    double? theTemp,
    double? windSpeed,
    double? windDirection,
    double? airPressure,
    int? humidity,
    double? visibility,
    int? predictability,
  }) {
    return Weather(
      id: id ?? this.id,
      weatherStateName: weatherStateName ?? this.weatherStateName,
      weatherStateAbbr: weatherStateAbbr ?? this.weatherStateAbbr,
      windDirectionCompass: windDirectionCompass ?? this.windDirectionCompass,
      created: created ?? this.created,
      applicableDate: applicableDate ?? this.applicableDate,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      theTemp: theTemp ?? this.theTemp,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      airPressure: airPressure ?? this.airPressure,
      humidity: humidity ?? this.humidity,
      visibility: visibility ?? this.visibility,
      predictability: predictability ?? this.predictability,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weatherStateName': weatherStateName,
      'weatherStateAbbr': weatherStateAbbr.text,
      'windDirectionCompass': windDirectionCompass.text,
      'created': created.millisecondsSinceEpoch,
      'applicableDate': applicableDate.millisecondsSinceEpoch,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'theTemp': theTemp,
      'windSpeed': windSpeed,
      'windDirection': windDirection,
      'airPressure': airPressure,
      'humidity': humidity,
      'visibility': visibility,
      'predictability': predictability,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'],
      weatherStateName: map['weather_state_name'],
      weatherStateAbbr: WeatherState.values.firstWhere((element) => element.text == (map['weather_state_abbr'] as String), orElse: () => WeatherState.unknown),
      windDirectionCompass: WindDirectionCompass.values.firstWhere((element) => element.text == (map['wind_direction_compass'] as String), orElse: () => WindDirectionCompass.unknown),
      created: DateTime.parse(map['created']),
      applicableDate: DateTime.parse(map['applicable_date']),
      minTemp: map['min_temp'],
      maxTemp: map['max_temp'],
      theTemp: map['the_temp'],
      windSpeed: map['wind_speed'],
      windDirection: map['wind_direction'],
      airPressure: map['air_pressure'],
      humidity: map['humidity'],
      visibility: map['visibility'],
      predictability: map['predictability'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Weather(id: $id, weatherStateName: $weatherStateName, weatherStateAbbr: $weatherStateAbbr, windDirectionCompass: $windDirectionCompass, created: $created, applicableDate: $applicableDate, minTemp: $minTemp, maxTemp: $maxTemp, theTemp: $theTemp, windSpeed: $windSpeed, windDirection: $windDirection, airPressure: $airPressure, humidity: $humidity, visibility: $visibility, predictability: $predictability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        other.id == id &&
        other.weatherStateName == weatherStateName &&
        other.weatherStateAbbr == weatherStateAbbr &&
        other.windDirectionCompass == windDirectionCompass &&
        other.created == created &&
        other.applicableDate == applicableDate &&
        other.minTemp == minTemp &&
        other.maxTemp == maxTemp &&
        other.theTemp == theTemp &&
        other.windSpeed == windSpeed &&
        other.windDirection == windDirection &&
        other.airPressure == airPressure &&
        other.humidity == humidity &&
        other.visibility == visibility &&
        other.predictability == predictability;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        weatherStateName.hashCode ^
        weatherStateAbbr.hashCode ^
        windDirectionCompass.hashCode ^
        created.hashCode ^
        applicableDate.hashCode ^
        minTemp.hashCode ^
        maxTemp.hashCode ^
        theTemp.hashCode ^
        windSpeed.hashCode ^
        windDirection.hashCode ^
        airPressure.hashCode ^
        humidity.hashCode ^
        visibility.hashCode ^
        predictability.hashCode;
  }
}
