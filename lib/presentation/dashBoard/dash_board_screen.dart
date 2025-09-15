
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_navigation_bar.dart';
import 'dash_board_controller.dart';

class DashBoardScreen extends GetView<DashBoardController> {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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