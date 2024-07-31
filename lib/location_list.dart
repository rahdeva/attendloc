import 'package:attendloc/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationListWidget extends StatelessWidget {
  final AttendanceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.locations.length,
        itemBuilder: (context, index) {
          final location = controller.locations[index];
          return ListTile(
            title: Text(location.name),
            subtitle: Text(
                'Lat: ${location.position.latitude}, Lng: ${location.position.longitude}'),
          );
        },
      );
    });
  }
}
