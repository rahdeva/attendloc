import 'package:attendloc/main_controller.dart';
import 'package:attendloc/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateLocationScreen extends StatefulWidget {
  @override
  _CreateLocationScreenState createState() => _CreateLocationScreenState();
}

class _CreateLocationScreenState extends State<CreateLocationScreen> {
  late GoogleMapController mapController;
  LatLng? _selectedLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AttendancesController controller = Get.find();
    
    return Scaffold(
      appBar: AppBar(title: Text("Create Location")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onTap,
              initialCameraPosition: CameraPosition(
                target: LatLng(-8.650000, 115.216667),
                zoom: 15,
              ),
              markers: _selectedLocation == null
                  ? {}
                  : {
                      Marker(
                        markerId: MarkerId("selectedLocation"),
                        position: _selectedLocation!,
                      ),
                    },
            ),
          ),
          if (_selectedLocation != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  String id = DateTime.now().toString();
                  controller.addLocation(LocationDataApp(
                    id: id,
                    name: "Location $id",
                    position: _selectedLocation!,
                  ));
                  Get.back();
                },
                child: Text("Save Location"),
              ),
            ),
        ],
      ),
    );
  }
}
