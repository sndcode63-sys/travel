
import 'package:get/get.dart';

import 'meeting_list_controller.dart';

class MeetingListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MeetingListController>(() => MeetingListController());
  }
}