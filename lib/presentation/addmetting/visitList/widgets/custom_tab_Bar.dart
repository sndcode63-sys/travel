import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travell_booking_app/presentation/addmetting/VIsitPending/visit_pending_screen.dart';
import 'package:travell_booking_app/presentation/addmetting/VisitRejected/visit_rejected_screen.dart';
import 'package:travell_booking_app/presentation/addmetting/visitList/visit_all/visit_all_screen.dart';
import 'package:travell_booking_app/presentation/addmetting/visitList/visit_approved/visit_approved_screen.dart';

class CustomTabs extends StatelessWidget {
  CustomTabs({super.key});

  final List<String> defaultTabs = [
    "All",
    "Approved",
    "Pending",
    "Rejected",

  ];

  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: selectedIndex,
          builder: (context, currentIndex, _) {
            return customTabBarCore(
              tabs: defaultTabs,
              selectedIndex: currentIndex,
              onTap: (index) {
                selectedIndex.value = index;
              },
            );
          },
        ),
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (context, currentIndex, _) {
              return IndexedStack(
                index: currentIndex,
                children: [
                  VisitAllScreen(),
                  VisitApprovedScreen(),
                  VisitPendingScreen(),
                  VisitRejectedScreen(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget customTabBarCore({
    required List<String> tabs,
    required int selectedIndex,
    required Function(int) onTap,
    double height = 50,
    Color selectedColor = Colors.green,
    Color unselectedColor = Colors.grey,
  }) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: isSelected ? selectedColor : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? selectedColor
                      : unselectedColor.withAlpha(75),
                  width: 1,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : unselectedColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
