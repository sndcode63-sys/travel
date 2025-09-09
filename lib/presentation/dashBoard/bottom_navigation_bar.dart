import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dash_board_controller.dart';

/// HomeScreen with Scaffold + PageView + BottomNav
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        DashBoardController());

    return Scaffold(
      body: Obx(() => PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: controller.views,
      )),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
        selectedIndex: controller.selectedIndex.value,
        onItemTapped: controller.onItemTapped,
      )),
    );
  }
}