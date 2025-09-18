import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_controller.dart';

import 'spalsh_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}