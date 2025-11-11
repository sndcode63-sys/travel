import 'package:get/get.dart';
import 'relation_information_controller.dart';

class AssociateRelationInformationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssociateRelationInformationController>(() => AssociateRelationInformationController());
  }
}