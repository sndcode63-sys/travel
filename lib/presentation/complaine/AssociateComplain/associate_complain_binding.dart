import 'package:get/get.dart';
import 'associate_complain_controller.dart';

class AssociateComplainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AssociateComplainController>(() => AssociateComplainController());
  }
}