import 'package:get/get.dart';
import 'profile_info_controller.dart';

class ProfileInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileInfoController>(() => ProfileInfoController());
  }
}