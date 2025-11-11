import 'package:get/get.dart';
import 'associate_list_controller.dart';
class AssociateListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssociateListController>(() => AssociateListController());
  }
}