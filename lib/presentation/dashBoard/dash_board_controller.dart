import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../bottom_navigation_bar.dart';
import '../addVisit/add_visit_screen.dart';
import '../addmetting/add_meeting_screen.dart';
import '../home/hom_screen.dart';
import '../settings/setting_screen.dart';
import 'dash_board_screen.dart';

class DashboardController extends GetxController {
  final PageController pageController = PageController();
  final RxInt selectedIndex = 0.obs;

  final List<Widget> views = [
    HomScreen(),
    AddVisitScreen(),
    Container(
      color: Colors.green,
      child: const Center(child: Text("Menu Screen")),
    ),
    const AddMeetingScreen(),
    const SettingScreen(),
  ];

  void onItemTapped(int index) {
    if (index >= 0 && index < views.length) {
      selectedIndex.value = index;
      pageController.jumpToPage(index);
    }
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

