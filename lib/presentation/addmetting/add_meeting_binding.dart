import 'package:get/get.dart';

import 'add_meeting_controller.dart';

class AddMeetingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddMeetingController>(() => AddMeetingController());
  }
}