import 'package:get/get.dart';
import 'associate_profile_info_controller.dart';
class AssociateProfileInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssociateProfileInfoController>(() => AssociateProfileInfoController());
  }
}