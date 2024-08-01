import 'package:attendloc/feature/choose_location/choose_location_controller.dart';
import 'package:get/get.dart';

class ChooseLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseLocationController>(() => ChooseLocationController());
  }
}
