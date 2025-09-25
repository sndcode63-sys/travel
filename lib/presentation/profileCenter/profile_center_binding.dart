import 'package:get/get.dart';
import 'profile_center_controller.dart';

class ProfileCenterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileCenterController>(() => ProfileCenterController());
  }
}