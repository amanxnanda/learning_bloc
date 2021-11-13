part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;

  String get text {
    switch (this) {
      case WeatherStatus.initial:
        return 'initial';
      case WeatherStatus.loading:
        return 'loading';

      case WeatherStatus.success:
        return 'success';

      case WeatherStatus.failure:
        return 'failure';
    }
  }
}

class WeatherState extends Equatable {
  WeatherState({
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celsius,
    Weather? weather,
  }) : weather = weather ?? Weather.empty;

  final WeatherStatus status;
  final Weather weather;
  final TemperatureUnits temperatureUnits;

  @override
  List<Object> get props => [status, weather, temperatureUnits];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {
      'status': status.text,
      'weather': weather.toMap(),
      'temperatureUnits': temperatureUnits.text,
    };
  }

  factory WeatherState.fromMap(Map<String, dynamic> map) {
    return WeatherState(
      status: WeatherStatus.values.firstWhere((element) => element.text == map['status']),
      temperatureUnits: TemperatureUnits.values.firstWhere((element) => element.text == map['temperatureUnits']),
      weather: Weather.fromMap(map['weather']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherState.fromJson(String source) => WeatherState.fromMap(json.decode(source));

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    TemperatureUnits? temperatureUnits,
  }) =>
      WeatherState(
        status: status ?? this.status,
        weather: weather ?? this.weather,
        temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      );
}
