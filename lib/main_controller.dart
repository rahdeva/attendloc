import 'package:attendloc/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceController extends GetxController {
  var locations = <LocationDataApp>[].obs;
  var attendances = <AttendanceData>[].obs;

  void addLocation(LocationDataApp location) {
    locations.add(location);
  }

  void addAttendance(AttendanceData attendance) {
    attendances.add(attendance);
  }

  bool checkDistance(LatLng userPosition, LatLng pinPosition) {
    double distance = Geolocator.distanceBetween(
      userPosition.latitude, userPosition.longitude,
      pinPosition.latitude, pinPosition.longitude,
    );
    return distance <= 50;
  }

  void checkIn(BuildContext context) async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    LatLng userPosition = LatLng(
      _locationData.latitude!,
      _locationData.longitude!,
    );

    final controller = Get.find<AttendanceController>();
    final validLocation = controller.locations.firstWhere(
        (location) => controller.checkDistance(userPosition, location.position),
        orElse: () => LocationDataApp(
            id: 'invalid', name: 'Invalid', position: LatLng(0, 0)));

    bool isValid = validLocation.id != 'invalid';

    controller.addAttendance(AttendanceData(
      userId: 'User123',
      timestamp: DateTime.now(),
      position: userPosition,
      isValid: isValid,
    ));
  }

}
