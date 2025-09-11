import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/liberary/library_controller.dart';

class LibraryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LibraryController>(()=> LibraryController());
  }
}