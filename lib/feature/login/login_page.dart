import 'package:attendloc/feature/login/login_controller.dart';
import 'package:attendloc/resources/resources.dart';
import 'package:attendloc/utills/helper/validator.dart';
import 'package:attendloc/utills/widget/button/primary_button.dart';
import 'package:attendloc/utills/widget/forms/label_form_widget.dart';
import 'package:attendloc/utills/widget/forms/text_field_widget.dart';
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
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
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
                      const LabelFormWidget(labelText: "Email"),
                      TextFieldWidget(
                        name: 'email',
                        hintText: 'Enter your email',
                        validator: Validator.required(),
                        keyboardType: TextInputType.text, 
                      ),
                      const SizedBox(height: 16),
                      const LabelFormWidget(labelText: "Password"),
                      TextFieldWidget(
                        hintText: "Enter your password",
                        name: 'password',
                        obsecure: controller.isObscure,
                        validator: Validator.required(),
                        keyboardType: TextInputType.text,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.isObscure = !controller.isObscure;
                            controller.update();
                          },
                          icon: controller.isObscure
                            ? const Icon(
                                Icons.visibility_outlined,
                                color: AppColors.colorPrimary,
                              )
                            : const Icon(
                                Icons.visibility_off_outlined,
                                color: AppColors.colorPrimary,
                              ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      PrimaryButton(
                        title: "Login",
                        onPressed: () async {
                          if (
                            controller.formKey.currentState != null &&
                            controller.formKey.currentState!.saveAndValidate()
                          ){
                            controller.loginEmail(
                              context: context,
                              emailInput: controller.formKey.currentState!.fields['email']!.value,
                              passwordInput: controller.formKey.currentState!.fields['password']!.value,
                            );
                          }
                        },
                      ),
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
