import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_controller.dart';

import 'my_complaint_data_controller.dart';

class MyComplaintDataBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyComplaintDataController>(() => MyComplaintDataController(),);
  }
}