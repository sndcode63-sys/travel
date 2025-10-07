import 'package:get/get.dart';
import 'complainDispute_controller.dart';


class ComplainDisputeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ComplaindisputeController>(() => ComplaindisputeController());
  }
}