
import 'package:attendloc/feature/choose_location/choose_location_controller.dart';
import 'package:attendloc/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocationPage extends StatelessWidget {
  const ChooseLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseLocationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text("Choose Location")),
          body: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                  return GoogleMap(
                    onMapCreated: (GoogleMapController mapC) {
                      controller.mapController = mapC;
                    },
                    onTap: (LatLng position) {
                      controller.setSelectedLocation(position);
                    },
                    myLocationEnabled : true,
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLocation.value ?? const LatLng(-8.650000, 115.216667),
                      zoom: 18,
                    ),
                    markers: controller.selectedLocation.value == null
                        ? {}
                        : {
                            Marker(
                              markerId: const MarkerId("selectedLocation"),
                              position: controller.selectedLocation.value!,
                            ),
                          },
                  );
                }),
              ),
              Obx(() {
                if (controller.selectedLocation.value != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.saveLocation();
                      },
                      child: Text(
                        "Save Location",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink(); // Return an empty widget if no location is selected
                }
              }),
            ],
          ),
        );
      }
    );
  }
}
