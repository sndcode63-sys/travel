
import 'package:get/get.dart';
import 'controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());

  }
}
