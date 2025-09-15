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
  final pageController = PageController();
  final selectedIndex = 0.obs;
  final List<Widget> views = [
    HomScreen(),
    AddVisitScreen()
    ,
    Container(
      color: Colors.green,
      child: Center(child: Text("Menu Screen")),
    ), // 2 (center button)
    AddMeetingScreen(),
    Container(color: Colors.blue, child: Center(child: Text("Settings"))), // 4
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

