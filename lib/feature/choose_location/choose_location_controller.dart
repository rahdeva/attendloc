import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocationController extends GetxController {
  GoogleMapController? mapController;
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  var currentLocation = Rx<LatLng?>(null);

  @override
  void onInit() async {
    await getCurrentLocation();
    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation.value = LatLng(position.latitude, position.longitude);
      moveCameraToCurrentLocation();
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
    update();
  }

  void moveCameraToCurrentLocation() {
    if (currentLocation.value != null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLng(currentLocation.value!),
      );
    }
  }

  void setSelectedLocation(LatLng position) {
    selectedLocation.value = position;
  }

  void saveLocation() {
    if (selectedLocation.value != null) {
      Get.back(
        result: {
          "latitude": selectedLocation.value!.latitude,
          "longitude": selectedLocation.value!.longitude,
        } 
      );
    }
  }
}
