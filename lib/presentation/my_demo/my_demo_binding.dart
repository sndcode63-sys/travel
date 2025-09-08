import 'package:get/get.dart';
import 'my_demo_controller.dart';

class MyDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDemoController>(() => MyDemoController());
  }
}
