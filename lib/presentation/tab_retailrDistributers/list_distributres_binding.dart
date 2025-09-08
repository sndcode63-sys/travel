import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/tab_retailrDistributers/list_distributres_controller.dart';

class ListDistributresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListDistributresController>(() => ListDistributresController());

  }
}