import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_controller.dart';

import 'verification_doc_controller.dart';

class VerificationDocBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VerificationDocController>(() => VerificationDocController());
  }
}