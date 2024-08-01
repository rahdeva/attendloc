class OfficeLocation {
  final String locationId; 
  final String name;
  final double latitude;
  final double longitude;

  OfficeLocation({
    required this.locationId,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  factory OfficeLocation.fromJson(Map<String, dynamic> json) {
    return OfficeLocation(
      locationId: json['location_id'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
    };
  }
}
