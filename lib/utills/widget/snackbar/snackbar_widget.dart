import 'package:attendloc/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarWidget{
  static void defaultSnackbar({
    RxBool? isDissmiss, 
    required Widget icon,
    required String title, 
    required String subtitle, 
  }){
    Get.snackbar(
      title,
      subtitle,
      snackPosition: SnackPosition.BOTTOM,
      icon: icon,
      backgroundColor: AppColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(20),
      colorText: AppColors.black,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      snackbarStatus: (status) => status == SnackbarStatus.CLOSED
          ? isDissmiss?.value = false
          : isDissmiss?.value = true,
      boxShadows: [
        AppElevation.elevation4px
      ]
    );
  }
}

