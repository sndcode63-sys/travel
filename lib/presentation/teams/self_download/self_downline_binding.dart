import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_controller.dart';

class SelfDownlineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SelfController>(() => SelfController());
  }
}