import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/dashBoard/dash_board_screen.dart';

import 'dispute_enter_summary_controller.dart';



class DisputeEnterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DisputeEnterSummaryController>(() => DisputeEnterSummaryController());
  }
}