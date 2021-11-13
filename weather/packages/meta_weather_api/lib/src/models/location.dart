import 'dart:convert';

enum LocationType { city, region, state, province, country, continent }

extension on LocationType {
  String get text {
    switch (this) {
      case LocationType.city:
        return 'City';
      case LocationType.region:
        return 'Region';

      case LocationType.state:
        return 'State';

      case LocationType.province:
        return 'Province';

      case LocationType.country:
        return 'Country';

      case LocationType.continent:
        return 'Continent';
    }
  }
}

class Location {
  final String title;
  final LocationType locationType;
  final int woeid;
  final LatLong latLong;
  Location({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.latLong,
  });

  Location copyWith({
    String? title,
    LocationType? locationType,
    int? woeid,
    LatLong? latLong,
  }) {
    return Location(
      title: title ?? this.title,
      locationType: locationType ?? this.locationType,
      woeid: woeid ?? this.woeid,
      latLong: latLong ?? this.latLong,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'locationType': locationType.text,
      'woeid': woeid,
      'latLong': latLong.toMap(),
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) => Location(
        title: map['title'],
        locationType: LocationType.values.firstWhere((element) => element.text == (map['locationType'] as String)),
        woeid: map['woeid'],
        latLong: LatLong.fromMap(map['latLong'] as String),
      );

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(title: $title, locationType: $locationType, woeid: $woeid, latLong: $latLong)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location && other.title == title && other.locationType == locationType && other.woeid == woeid && other.latLong == latLong;
  }

  @override
  int get hashCode {
    return title.hashCode ^ locationType.hashCode ^ woeid.hashCode ^ latLong.hashCode;
  }
}

class LatLong {
  final double lat;
  final double long;
  LatLong({
    required this.lat,
    required this.long,
  });

  LatLong copyWith({
    double? lat,
    double? long,
  }) {
    return LatLong(
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  String toMap() => '$lat,$long';

  factory LatLong.fromMap(String map) {
    final latLong = map.split(',');
    return LatLong(
      lat: double.tryParse(latLong.first) ?? 0,
      long: double.tryParse(latLong.last) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LatLong.fromJson(String source) => LatLong.fromMap(json.decode(source));

  @override
  String toString() => 'LatLong(lat: $lat, long: $long)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLong && other.lat == lat && other.long == long;
  }

  @override
  int get hashCode => lat.hashCode ^ long.hashCode;
}
