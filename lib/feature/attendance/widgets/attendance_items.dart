import 'package:attendloc/feature/attendance/attendance_controller.dart';
import 'package:flutter/material.dart';
import '/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AttendanceListItem extends StatelessWidget {
  final int index;
  final AttendanceController controller;
  // final Hospital mData;

  const AttendanceListItem({
    Key? key, 
    required this.index, 
    required this.controller, 
    // required this.mData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: const BoxDecoration(
        color: AppColors.surface,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "08:43 AM",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textColour80,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(200)
            ),
            child: Text(
              "IN",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.surface,
              ),
            ),
          )
        ],
      ),
    );
  }
}
