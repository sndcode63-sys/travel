import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/home/home_controller.dart';
import 'package:travell_booking_app/presentation/settings/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}