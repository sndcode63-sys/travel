import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/home/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}