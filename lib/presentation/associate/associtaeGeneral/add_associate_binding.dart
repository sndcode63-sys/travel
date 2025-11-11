import 'package:get/get.dart';
import 'add_associate_controller.dart';

class AddAssociateBinding extends Bindings{
  @override
  void dependencies() {
      Get.lazyPut<AddAssociateController>(() => AddAssociateController());
  }
}