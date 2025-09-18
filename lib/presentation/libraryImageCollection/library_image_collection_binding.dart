import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_controller.dart';

class LibraryImageCollectionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LibraryImageCollectionController>(() => LibraryImageCollectionController(),);
  }
}