import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/home/home_controller.dart';
import 'package:travell_booking_app/presentation/settings/setting_controller.dart';

import 'privacy_policy_controller.dart';

class PrivacyPolicyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());
  }
}