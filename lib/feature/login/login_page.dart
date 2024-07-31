import 'package:attendloc/feature/login/login_controller.dart';
import 'package:attendloc/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return FormBuilder(
              key: controller.formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AppImages.imgLogo.image().image
                          )
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "AttendLoc",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorPrimary
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "txt_general_username".tr,
                      //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      //       color: AppColors.textColour70
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      // FormBuilderTextField(
                      //   name: 'username',
                      //   enabled: !controller.isLoading,
                      //   decoration: InputDecoration(
                      //     hintText: 'txt_general_username'.tr,
                      //   ),
                      //   validator: Validator.required(),
                      //   keyboardType: TextInputType.emailAddress,
                      //   maxLines: 1,
                      //   onChanged: (text) {

                      //   },
                      // ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
