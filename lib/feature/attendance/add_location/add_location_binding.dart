import 'package:attendloc/feature/attendance/add_location/add_location_controller.dart';
import 'package:get/get.dart';

class AddLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLocationController>(() => AddLocationController());
  }
}
