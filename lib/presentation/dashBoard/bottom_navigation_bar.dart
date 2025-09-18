import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/color_constants.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/uHelper.dart';

import '../../utlis/constents/img_constants.dart';
import 'dash_board_controller.dart';

/// HomeScreen with Scaffold + PageView + BottomNav
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashBoardController());

    return Scaffold(
      body: Obx(
        () => PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.views,
        ),
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
final dark = UHelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? UColors.black: UColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.08,
            ),
            blurRadius: 12,
            spreadRadius:6,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
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
                _buildNavItem(context, 0, Icons.home, 'Home'),
                _buildNavItem(
                  context,
                  1,
                  Icons.add_circle_outline,
                  'Add Visit',
                ),
                const SizedBox(width: 80),
                _buildNavItem(context, 3, Icons.people_outline, 'Meeting'),
                _buildNavItem(context, 4, Icons.settings, 'Setting'),
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

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final theme = Theme.of(context);
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey,
          ),

          Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? AppColors.primary : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
