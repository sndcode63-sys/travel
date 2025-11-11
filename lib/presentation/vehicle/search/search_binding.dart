import 'package:get/get.dart';
import 'search_controller.dart';

class SearchVehicleBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchVehicleController>(() => SearchVehicleController());
  }
}