import 'package:attendloc/feature/attendance/attendance_controller.dart';
import 'package:attendloc/model/location.dart';
import 'package:attendloc/resources/resources.dart';
import 'package:attendloc/routes/page_names.dart';
import 'package:attendloc/utills/widget/pop_up/pop_up_widget.dart';
import 'package:attendloc/utills/widget/snackbar/snackbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AddLocationController extends GetxController {
  final AttendanceController attendanceController = AttendanceController.find;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  double? newLocLatitude;
  double? newLocLongitude;

  void chooseLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Permission Denied",
          subtitle: "Location permission is required to track attendance.",
        );
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Permission Denied Forever",
        subtitle: "Location permission is permanently denied. Please enable it in settings.",
      );
      return;
    }

    final selectedLocation = await Get.toNamed(PageName.CHOOSE_LOCATION);
    if (selectedLocation != null) {
      newLocLatitude = selectedLocation["latitude"];
      newLocLongitude = selectedLocation["longitude"];
    }
    update();
  }

  Future<void> addLocation({
    required BuildContext context,
    required String locationName,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final locationId = FirebaseFirestore.instance.collection('locations').doc().id;

      final officeLocation = OfficeLocation(
        locationId: FirebaseFirestore.instance.collection('locations').doc().id,
        name: locationName,
        latitude: latitude,
        longitude: longitude,
      );

      await FirebaseFirestore.instance
        .collection('location')
        .doc(locationId)
        .set(officeLocation.toJson());

      formKey.currentState?.reset();
      Get.back();
      attendanceController.getOffices();
      PopUpWidget.successAndFailPopUp(
        // ignore: use_build_context_synchronously
        context: context, 
        titleString: "Success!", 
        middleText: "Location added successfully.", 
        buttonText: "OK"
      );
      
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Oops!",
        subtitle: "Failed to add location.",
      );
    }
  }
}
