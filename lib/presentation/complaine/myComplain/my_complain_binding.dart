import 'package:get/get.dart';
import 'my_complain_controller.dart';

class MyComplainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyComplainController>(() => MyComplainController());
  }
}