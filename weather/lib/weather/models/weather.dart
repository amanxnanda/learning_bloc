import 'dart:convert';

import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart' as weather_repository;

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;

  String get text {
    switch (this) {
      case TemperatureUnits.fahrenheit:
        return 'fahrenheit';
      case TemperatureUnits.celsius:
        return 'celsius';
    }
  }
}

class Temperature {
  final double value;
  const Temperature({
    required this.value,
  });

  Temperature copyWith({
    double? value,
  }) {
    return Temperature(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory Temperature.fromMap(Map<String, dynamic> map) {
    return Temperature(
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Temperature.fromJson(String source) => Temperature.fromMap(json.decode(source));

  @override
  String toString() => 'Temperature(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Temperature && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

class Weather {
  final WeatherCondition condition;

  final DateTime lastUpdate;
  final String location;
  final Temperature temperature;
  Weather({
    required this.condition,
    required this.lastUpdate,
    required this.location,
    required this.temperature,
  });

  Weather copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdate,
    String? location,
    Temperature? temperature,
  }) =>
      Weather(
        condition: condition ?? this.condition,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        location: location ?? this.location,
        temperature: temperature ?? this.temperature,
      );

  static final empty = Weather(
    condition: WeatherCondition.unknown,
    lastUpdate: DateTime(0),
    temperature: const Temperature(value: 0),
    location: '--',
  );

  @override
  String toString() => 'Weather(condition: $condition, lastUpdate: $lastUpdate, location: $location, temperature: $temperature)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather && other.condition == condition && other.lastUpdate == lastUpdate && other.location == location && other.temperature == temperature;
  }

  @override
  int get hashCode {
    return condition.hashCode ^ lastUpdate.hashCode ^ location.hashCode ^ temperature.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'condition': condition.text,
      'lastUpdate': lastUpdate.toString(),
      'location': location,
      'temperature': temperature.toMap(),
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      condition: WeatherCondition.values.firstWhere((element) => element.text == map['condition']),
      lastUpdate: DateTime.parse(map['lastUpdate']),
      location: map['location'],
      temperature: Temperature.fromMap(map['temperature']),
    );
  }

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      condition: weather.condition,
      lastUpdate: DateTime.now(),
      location: weather.location,
      temperature: Temperature(value: weather.temperature),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source));
}
