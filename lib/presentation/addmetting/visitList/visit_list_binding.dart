
import 'package:get/get.dart';

import 'visit_list_controller.dart';

class VisitListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VisitListController>(() => VisitListController());
  }
}