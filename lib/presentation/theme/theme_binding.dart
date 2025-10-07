import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/home/home_controller.dart';
import 'package:travell_booking_app/presentation/theme/theme_controller.dart';

class ThemeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}