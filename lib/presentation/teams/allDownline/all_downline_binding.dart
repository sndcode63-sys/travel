
import 'package:get/get.dart';

import 'all_downline_controller.dart';

class AllDownlineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AllDownlineController>(() => AllDownlineController());
  }
}