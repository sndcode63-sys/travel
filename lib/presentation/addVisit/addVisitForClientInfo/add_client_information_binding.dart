import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information_controller.dart';

class AddClientInformationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddClientInformationController>(() => AddClientInformationController());
  }
}