import 'package:get/get.dart';
import 'relation_information_controller.dart';

class RelationInformationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RelationInformationController>(() => RelationInformationController());
  }
}