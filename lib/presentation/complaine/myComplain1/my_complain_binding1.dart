import 'package:get/get.dart';
import 'my_complain_controller1.dart';

class MyComplainBinding1 extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyComplainController1>(() => MyComplainController1());
  }
}