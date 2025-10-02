
import 'package:get/get.dart';

import 'visit_all_controller.dart';

class VisitAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitAllController>(() => VisitAllController());
  }
}