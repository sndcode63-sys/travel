import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_controller.dart';

class AddVisitBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddVisitController>(() => AddVisitController());
  }
}