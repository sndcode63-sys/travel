import 'package:get/get.dart';
import 'bank_verification_controller.dart';

class AssociateBankVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssociateBankVerificationController>(() => AssociateBankVerificationController());
  }
}