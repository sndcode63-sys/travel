import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../addVisit/add_visit_controller.dart';
import '../addVisit/add_visit_screen.dart';
import '../addmetting/add_meeting_screen.dart';
import '../home/hom_screen.dart';
import '../home/wigets/diloag_home.dart';
import '../settings/setting_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final PageController pageController = PageController();
  final RxInt selectedIndex = 0.obs;

  final RxList<Widget?> views = <Widget?>[
    HomScreen(),
    null,
    const SizedBox.shrink(),
    const AddMeetingScreen(),
    const SettingScreen(),
  ].obs;

  void onItemTapped(int index, BuildContext context) {
    if (index == 2) {
      showActivityPopup(context);
      return;
    }

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
    if (index == 1) {
      if (!Get.isRegistered<AddVisitController>()) {
        Get.put(AddVisitController());
      }

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

