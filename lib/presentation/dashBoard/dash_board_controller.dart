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
    AddClientInformation(),
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

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home, 'Home'),
                _buildNavItem(1, Icons.add_circle_outline, 'Add Visit'),
                const SizedBox(width: 80), // Center button ke liye jagah
                _buildNavItem(3, Icons.people_outline, 'Meeting'),
                _buildNavItem(4, Icons.settings, 'Setting'),
              ],
            ),
          ),
          Positioned(
            top: -38,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: GestureDetector(
              onTap: () => onItemTapped(2),
              child: Image.asset(AppImages.menu),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selectedIndex == index ? Colors.deepPurple : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.deepPurple : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
