import 'package:get/get.dart';
import 'vehicle_controller.dart';

class VehicleListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VehicleController>(() => VehicleController());
  }
}