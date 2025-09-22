
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utlis/constents/uHelper.dart';
import '../../bottom_navigation_bar.dart';
import '../addVisit/add_visit_screen.dart';
import '../addmetting/add_meeting_screen.dart';
import '../home/hom_screen.dart';
import '../settings/setting_screen.dart';
import 'dash_board_controller.dart';

class DashBoardScreen extends GetView<DashboardController> {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: controller.views,
      ),
      bottomNavigationBar: Obx(
            () => CustomBottomNavBar(
          selectedIndex: controller.selectedIndex.value,
          onItemTapped: controller.onItemTapped,
        ),
      ),
    );
  }
}
