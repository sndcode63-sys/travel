
import 'package:get/get.dart';

import 'meeting_all_controller.dart';

class MeetingListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingAllController>(() => MeetingAllController());
  }
}