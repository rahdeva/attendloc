
import 'package:attendloc/feature/add_location/add_location_controller.dart';
import 'package:attendloc/resources/resources.dart';
import 'package:attendloc/utills/widget/app_bar/app_bar_widget.dart';
import 'package:attendloc/utills/widget/button/outlined_secondary_button.dart';
import 'package:attendloc/utills/widget/floating_action_button/floating_submit_button.dart';
import 'package:attendloc/utills/widget/forms/label_form_widget.dart';
import 'package:attendloc/utills/widget/forms/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../utills/helper/validator.dart';

class AddLocationPage extends StatelessWidget {
  const AddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget.simple(
            titleString: "Add New Office Location", 
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
                    const LabelFormWidget(labelText: "Location Name"),
                    TextFieldWidget(
                      name: 'locationName',
                      hintText: 'Location Name',
                      validator: Validator.required(),
                    ),
                    const SizedBox(height: 24),
                    Visibility(
                      visible: controller.newLocLatitude != null,
                      child: Column(
                        children: [
                          const LabelFormWidget(labelText: "Latitude"),
                          TextFieldWidget(
                            name: 'latitude',
                            hintText: "Latitude",
                            initialValue: controller.newLocLatitude.toString(),
                            validator: Validator.required(),
                            enabled: false,
                          ),
                          const SizedBox(height: 24),
                          const LabelFormWidget(labelText: "Longitude"),
                          TextFieldWidget(
                            name: 'longitude',
                            hintText: "Longitude",
                            initialValue: controller.newLocLongitude.toString(),
                            validator: Validator.required(),
                            enabled: false,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    OutlinedSecondaryButton(
                      icon: const Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.colorSecondary,
                      ),
                      title: "Choose Location",
                      onPressed: () {
                        controller.chooseLocation();
                      }
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
                controller.addLocation(
                  context: context, 
                  locationName: controller.formKey.currentState!.fields['locationName']!.value, 
                  latitude: double.parse(controller.formKey.currentState!.fields['latitude']!.value), 
                  longitude: double.parse(controller.formKey.currentState!.fields['longitude']!.value), 
                );
              }
            },
          ),
        );
      }
    );
  }
}
