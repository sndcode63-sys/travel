import 'package:get/get.dart';

import 'complain_with_me_controller.dart';

class ComplainWithMeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ComplainWithMeController>(() => ComplainWithMeController());
  }
}