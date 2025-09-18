import 'package:get/get.dart';
import 'package:get/get.dart';

// lib/app/modules/main/controllers/main_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_screen.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_info_screen.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_screen.dart';
import 'package:travell_booking_app/presentation/auth/login/login_screen.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/hom_screen.dart';

class DashBoardController extends GetxController {
  // PageView ka controller
  final PageController pageController = PageController();

  // Selected bottom navigation index (reactive)
  final RxInt selectedIndex = 0.obs;

  // Views list (sabhi screen yaha maintain hongi)
  final List<Widget> views = [
    HomScreen(),
    AddVisitScreen(),
    Container(
      color: Colors.green,
      child: Center(child: Text("Menu Screen")),
    ),
    AddMeetingScreen(),
    Container(
      color: Colors.blue,
      child: Center(child: Text("Settings")),
    ),
  ];

  //Jab bottom navigation item par tap ho
  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Agar user swipe kare PageView me
  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

