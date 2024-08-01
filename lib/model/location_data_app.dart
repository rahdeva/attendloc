import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDataApp {
  final String id;
  final String name;
  final LatLng position;

  LocationDataApp({
    required this.id,
    required this.name,
    required this.position,
  });

  // Convert from JSON
  factory LocationDataApp.fromJson(Map<String, dynamic> json) {
    return LocationDataApp(
      id: json['id'] as String,
      name: json['name'] as String,
      position: LatLng(
        json['latitude'] as double,
        json['longitude'] as double,
      ),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }
}
