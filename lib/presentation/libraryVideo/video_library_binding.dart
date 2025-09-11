import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/libraryVideo/video_library_controller.dart';

class VideoLibraryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VideoLibraryController>(() => VideoLibraryController(),);
  }
}