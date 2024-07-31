import 'package:attendloc/resources/resources.dart';
import 'package:attendloc/routes/page_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(PageName.LOGIN);
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: AppImages.imgLogo.image(
          width: 250,
          height: 250
        ),
      ),
    );
  }
}
