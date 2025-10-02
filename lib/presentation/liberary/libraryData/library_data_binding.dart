import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/liberary/library_controller.dart';

import 'library_data_controller.dart';

class LibraryDataBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LibraryDataController>(()=> LibraryDataController());
  }
}