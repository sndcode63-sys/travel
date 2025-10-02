import 'package:get/get.dart';
import 'bank_verification_controller.dart';

class BankVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BankVerificationController>(() => BankVerificationController());
  }
}