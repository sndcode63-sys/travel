import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/liberary/libraryHead/library_head_controller.dart';
import 'package:travell_booking_app/presentation/liberary/library_controller.dart';

class LibraryHeadBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LibraryHeadController>(()=> LibraryHeadController());
  }
}