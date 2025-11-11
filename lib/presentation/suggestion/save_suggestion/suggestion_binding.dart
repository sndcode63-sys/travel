import 'package:get/get.dart';
import 'suggestion_save_controller.dart';

class SuggestionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SuggestionSaveController>(() => SuggestionSaveController());
  }
}