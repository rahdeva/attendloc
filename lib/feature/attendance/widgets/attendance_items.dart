import 'package:attendloc/feature/attendance/attendance_controller.dart';
import 'package:attendloc/model/attendance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AttendanceListItem extends StatelessWidget {
  final int index;
  final AttendanceController controller;
  final Attendance mData;

  const AttendanceListItem({
    Key? key, 
    required this.index, 
    required this.controller, 
    required this.mData,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEE, d MMM yyyy').format(mData.datetime),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColour90
                  ),
                ),
                const SizedBox(height:8),
                Text(
                  DateFormat('HH:mm').format(mData.datetime),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColour80,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: mData.status == 1
                ? AppColors.success
                : AppColors.danger,
              borderRadius: BorderRadius.circular(200)
            ),
            child: Text(
              mData.status == 1
                ? "IN"
                : "OUT",
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
