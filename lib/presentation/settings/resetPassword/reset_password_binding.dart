import 'package:get/get.dart';
import 'reset_password_controller.dart';
class ResetPasswordBinding1 extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}