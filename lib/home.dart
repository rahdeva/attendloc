import 'package:attendloc/attendance_list.dart';
import 'package:attendloc/create_location.dart';
import 'package:attendloc/location_list.dart';
import 'package:attendloc/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final AttendancesController controller = Get.put(AttendancesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mobile Attendance")),
      body: Column(
        children: [
          Expanded(child: LocationListWidget()),
          Expanded(child: AttendanceListWidget()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateLocationScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
