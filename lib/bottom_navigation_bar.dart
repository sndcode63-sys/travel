import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'utlis/constents/colors.dart';
import 'utlis/constents/img_constants.dart';
import 'utlis/constents/uHelper.dart';

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
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final navBarHeight = 70.h;

    return Container(
      decoration: BoxDecoration(
        color: dark ? UColors.black : UColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12.r,
            spreadRadius: 6.r,
            offset: Offset(0, 4.h),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6.r,
            spreadRadius: 0,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      height: navBarHeight + bottomPadding,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 12.h,
          bottom: 12.h + bottomPadding,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildNavItem(context, 0, Icons.home, 'Home')),
                Expanded(child: _buildNavItem(context, 1, Icons.add_circle_outline, 'Add Visit')),

                const Spacer(flex: 1),

                Expanded(child: _buildNavItem(context, 3, Icons.people_outline, 'Meeting')),
                Expanded(child: _buildNavItem(context, 4, Icons.settings, 'Setting')),
              ],
            ),
            Positioned.fill(
              top: -40.h, 
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () => onItemTapped(2),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: SvgPicture.asset(AppImages.menus)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    final iconColor = isSelected ? UColors.primary : Colors.grey;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 24.sp),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
