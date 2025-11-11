import 'package:get/get.dart';

import 'adhar_verification_controller.dart';

class AadharVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AdharVerificationController>(() => AdharVerificationController());
  }
}