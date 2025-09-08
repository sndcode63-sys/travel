import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/c_chart/retailer/retailer_controller.dart';

class RetailerBindind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RetailerController>(() => RetailerController());

  }
}