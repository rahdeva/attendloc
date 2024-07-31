import 'package:attendloc/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceListWidget extends StatelessWidget {
  final AttendanceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.attendances.length,
        itemBuilder: (context, index) {
          final attendance = controller.attendances[index];
          return ListTile(
            title: Text('User: ${attendance.userId}'),
            subtitle: Text(
                'Time: ${attendance.timestamp}, Valid: ${attendance.isValid}'),
          );
        },
      );
    });
  }
}
