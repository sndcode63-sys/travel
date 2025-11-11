import 'package:get/get.dart';
import 'update_vehicle_controller.dart';

class UpdateVehicleBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UpdateVehicleController>(() => UpdateVehicleController());
  }
}