import 'package:get/get.dart';

import 'associate_tab_controller.dart';
class AssociateTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssociateTabController>(() => AssociateTabController());
  }
}