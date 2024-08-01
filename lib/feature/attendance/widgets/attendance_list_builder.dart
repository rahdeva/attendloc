import 'package:attendloc/feature/attendance/attendance_controller.dart';
import 'package:attendloc/feature/attendance/widgets/attendance_items.dart';
import 'package:flutter/material.dart';

class ListAttendanceBuilder extends StatelessWidget {
  const ListAttendanceBuilder({
    Key? key, 
    required this.controller, 
  }) : super(key: key);

  final AttendanceController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.listAttendance.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        return AttendanceListItem(
          index: index,
          controller: controller,
          mData: controller.listAttendance[index],
        );
      },
    );
  }
}
