import 'package:get/get.dart';

import 'general_information_controller.dart';

class GeneralInformationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GeneralInformationController>(() => GeneralInformationController());
  }
}