import 'package:get/get.dart';
import 'profile_pic_controller.dart';

class ProfilePicBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfilePicController>(() => ProfilePicController());
  }
}