import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../addVisit/add_visit_controller.dart';
import '../addVisit/add_visit_screen.dart';
import '../addmetting/add_meeting_screen.dart';
import '../home/hom_screen.dart';
import '../settings/setting_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final PageController pageController = PageController();
  final RxInt selectedIndex = 0.obs;

  // Lazy loaded screens
  final RxList<Widget?> views = <Widget?>[
    HomScreen(),
    null, // AddVisitScreen will be created lazily
    Container(
      color: Colors.green,
      child: const Center(child: Text("Menu Screen")),
    ),
    const AddMeetingScreen(),
    const SettingScreen(),
  ].obs;

  void onItemTapped(int index) {
    if (index >= 0 && index < views.length) {
      selectedIndex.value = index;
      pageController.jumpToPage(index);

      _initializeLazyScreen(index);
    }
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
    _initializeLazyScreen(index);
  }

  void _initializeLazyScreen(int index) {
    // Lazy load AddVisitScreen only when index 1 is selected
    if (index == 1) {
      if (!Get.isRegistered<AddVisitController>()) {
        Get.put(AddVisitController());
      }

      // Initialize the screen if not already created
      if (views[index] == null) {
        views[index] = AddVisitScreen();
      }

      final addVisitController = Get.find<AddVisitController>();
      addVisitController.detectLocation();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

