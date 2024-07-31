
import 'package:attendloc/feature/attendance/add_location/add_location_controller.dart';
import 'package:attendloc/utills/widget/app_bar/app_bar_widget.dart';
import 'package:attendloc/utills/widget/floating_action_button/floating_submit_button.dart';
import 'package:attendloc/utills/widget/forms/label_form_widget.dart';
import 'package:attendloc/utills/widget/forms/text_field_widget.dart';
import 'package:attendloc/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../utills/helper/validator.dart';

class AddLocationPage extends StatelessWidget {
  const AddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget.simple(
            titleString: "txt_medical_request_medical".tr, 
            context: context
          ),
          body: FormBuilder(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelFormWidget(labelText: "txt_medical_nama_pegawai".tr),
                    TextFieldWidget(
                      name: 'namaPegawai',
                      hintText: 'txt_medical_nama_pegawai'.tr,
                      validator: Validator.required(),
                      enabled: false,
                      initialValue: "GRANDI EKABUANA RAMDHANI",
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingSubmitButton(
            onPressed: (){
              if(
                controller.formKey.currentState != null &&
                controller.formKey.currentState!.saveAndValidate()
              ){
                PopUpWidget.successAndFailPopUp(
                  context: context, 
                  titleString: "txt_general_request_sent".tr, 
                  middleText: "txt_general_request_success".tr, 
                  buttonText: "txt_button_ok".tr
                );
              }
            },
          ),
        );
      }
    );
  }
}
