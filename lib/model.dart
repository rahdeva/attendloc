import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationDataApp {
  final String id;
  final String name;
  final LatLng position;

  LocationDataApp({required this.id, required this.name, required this.position});
}

class AttendanceData {
  final String userId;
  final DateTime timestamp;
  final LatLng position;
  final bool isValid;

  AttendanceData({required this.userId, required this.timestamp, required this.position, required this.isValid});
}
