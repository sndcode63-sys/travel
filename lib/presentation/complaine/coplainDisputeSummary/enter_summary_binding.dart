import 'package:get/get.dart';
import 'enter_summary_controller.dart';

class EnterSummaryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EnterSummaryController>(() => EnterSummaryController());
  }
}