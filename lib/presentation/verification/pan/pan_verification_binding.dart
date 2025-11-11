import 'package:get/get.dart';

import 'pan_verification_controller.dart';

class PanVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PanVerificationController>(() => PanVerificationController());
  }
}