
import 'package:attendloc/feature/attendance/attendance_controller.dart';
import 'package:attendloc/feature/attendance/widgets/attendance_list_builder.dart';
import 'package:attendloc/utills/widget/app_bar/app_bar_widget.dart';
import 'package:attendloc/utills/widget/forms/dropdown_search_widget.dart';
import 'package:attendloc/utills/widget/forms/label_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.simple(
        context: context, 
        titleString: "Attendance", 
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.logout)
          )
        ]
      ),
      body: GetBuilder<AttendanceController>(
        builder: (controller) {
          // return SmartRefresher(
          //   enablePullDown: true,
          //   enablePullUp: controller.hasNext.value,
          //   controller: controller.refreshController,
          //   onRefresh: controller.refreshPage,
          //   onLoading: controller.loadNextPage,
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        LabelFormWidget(
                          labelText: "txt_live_attendance_pilih_lokasi".tr,
                        ),
                        DropdownSearchWidget(
                          hintText: 'txt_live_attendance_lokasi_kerja'.tr,
                          selectedItem: controller.lokasiKerjaResult,
                          dropdownItems: controller.listLokasiKerja,
                          onChanged: (String? newValue){
                            controller.lokasiKerjaResult = newValue;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tue, 28 Feb 2023",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.textColour90
                              ),
                            ),
                            Text(
                              "Activity Log",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.colorSecondary
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListAttendanceBuilder(
                    controller: controller
                  ), 
                ],
              ),
            );
          // );
        }
      ),
    );
  }
}
