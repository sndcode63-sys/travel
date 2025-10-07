import 'package:get/get.dart';

import 'vehicleR_controller.dart';

class VehiclerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VehiclerController>(() => VehiclerController());
  }
}