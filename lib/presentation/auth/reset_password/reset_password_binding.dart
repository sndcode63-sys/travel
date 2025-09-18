import 'package:get/get.dart';

import 'reset_passowrd_controller.dart';

class ResetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ResetPassowrdController>(() => ResetPassowrdController());
  }
}