import 'dart:convert';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

extension on WeatherCondition {
  String get text {
    switch (this) {
      case WeatherCondition.clear:
        return 'clear';
      case WeatherCondition.rainy:
        return 'clear';
      case WeatherCondition.cloudy:
        return 'clear';
      case WeatherCondition.snowy:
        return 'clear';
      case WeatherCondition.unknown:
        return 'clear';
    }
  }
}

class Weather {
  final String location;
  final double temperature;
  final WeatherCondition condition;
  Weather({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  Weather copyWith({
    String? location,
    double? temperature,
    WeatherCondition? condition,
  }) {
    return Weather(
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
      condition: condition ?? this.condition,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'temperature': temperature,
      'condition': condition.text,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      location: map['location'],
      temperature: map['temperature'],
      condition: WeatherCondition.values.firstWhere((element) => element.text == (map['condition'] as String)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source));

  @override
  String toString() => 'Weather(location: $location, temperature: $temperature, condition: $condition)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather && other.location == location && other.temperature == temperature && other.condition == condition;
  }

  @override
  int get hashCode => location.hashCode ^ temperature.hashCode ^ condition.hashCode;
}
