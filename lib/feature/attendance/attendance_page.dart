
import 'package:attendloc/feature/attendance/attendance_controller.dart';
import 'package:attendloc/feature/attendance/widgets/attendance_list_builder.dart';
import 'package:attendloc/routes/page_names.dart';
import 'package:attendloc/utills/widget/app_bar/app_bar_widget.dart';
import 'package:attendloc/utills/widget/button/primary_button.dart';
import 'package:attendloc/utills/widget/empty/empty_state_widget.dart';
import 'package:attendloc/utills/widget/forms/dropdown_search_widget.dart';
import 'package:attendloc/utills/widget/forms/label_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget.simple(
            context: context, 
            titleString: "Attendance", 
            actions: [
              IconButton(
                onPressed: () => controller.logout(), 
                icon: const Icon(Icons.logout)
              )
            ]
          ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: controller.refreshController,
            onRefresh: controller.refreshPage,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login as : ${controller.userData?.email ?? "-"}",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColour90
                          ),
                        ),
                        Visibility(
                          visible: controller.userData?.role == "Admin",
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(PageName.ADD_LOCATION);
                            },
                            child: Container(
                              width: 100.w,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.colorPrimary,
                                boxShadow: [AppElevation.elevation4px]
                              ),
                              margin: const EdgeInsets.only(top: 24),
                              child: Center(
                                child: Text(
                                  '+ Add Office Location',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const LabelFormWidget(
                          labelText: "Offices",
                        ),
                        DropdownSearchWidget(
                          hintText: 'Choose office',
                          selectedItem: controller.officeResult,
                          dropdownItems: controller.officeNames,
                          onChanged: (String? newValue){
                            if(newValue == null){
                              controller.isOfficeChoosen.value = false;
                            } else{
                              controller.isOfficeChoosen.value = true;
                            }
                            controller.officeResult = newValue;
                          },
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.isOfficeChoosen.value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [AppElevation.elevation4px]
                              ),
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(top: 24),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.colorPrimary, width: 3),
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Attendance Time',
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textColour90
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          controller.timeString,
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColour90
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          controller.dateString,
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColour90
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      PrimaryButton(
                                        width: 35.w,
                                        title: "Clock In", 
                                        customColor: AppColors.success,
                                        onPressed: (){
                                          controller.addAttendance(context, 1);
                                        }
                                      ),
                                      const SizedBox(width: 16),
                                      PrimaryButton(
                                        width: 35.w,
                                        title: "Clock Out",
                                        customColor: AppColors.danger, 
                                        onPressed: (){
                                          controller.addAttendance(context, 2);
                                        }
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Attendance Log",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColour90
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  controller.listAttendance.isEmpty
                  ? const EmptyStateWidget()
                  : ListAttendanceBuilder(
                    controller: controller
                  ), 
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
