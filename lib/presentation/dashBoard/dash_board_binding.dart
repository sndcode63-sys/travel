import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/dashBoard/dash_board_screen.dart';

import 'dash_board_controller.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}