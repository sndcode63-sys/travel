import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import '../../../data/services/api_manager.dart';
import '../home_controller.dart';

class _CustomDrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final bool hasArrow;

  const _CustomDrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    // A slightly lighter purple/lavender color for the selected item (Home)
    const Color selectedColor = Color.fromARGB(255, 126, 73, 233);
    const Color defaultColor = Colors.transparent;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Material(
        // Background color for the item
        color: isSelected ? selectedColor : defaultColor,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.sp,
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                if (hasArrow)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeSliderDrawer extends StatelessWidget {
  const HomeSliderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeController ab sirf drawer item ke liye use hoga
    // User data ke liye AuthService use karenge
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        backgroundColor: UColors.primary,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Obx(() {
                final user = AuthService.to.userData.value;

                if (user == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                // Precache network image
                if (user.profilePic != null &&
                    user.profilePic!.isNotEmpty &&
                    !user.profilePic!.startsWith("data:image")) {
                  precacheImage(
                    CachedNetworkImageProvider("${user.fullImageUrl}${user.profilePic!}"),
                    context,
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: (user.profilePic != null && user.profilePic!.isNotEmpty)
                          ? (user.profilePic!.startsWith("data:image")
                          ? MemoryImage(base64Decode(user.profilePic!.split(",").last))
                      as ImageProvider
                          : CachedNetworkImageProvider("${user.fullImageUrl}${user.profilePic!}"))
                          : const AssetImage("assets/images/default_profile.png"),
                    ),
                    const SizedBox(height: 12),

                    // Name
                    Text(
                      user.name ?? "Unknown User",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),

                    // Email
                    Text(
                      user.email ?? "No Email",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                );
              }),
            ),

            // Drawer Items
            _CustomDrawerItem(
              icon: Icons.home_filled,
              label: "Home",
              isSelected: true,
              hasArrow: true,
              onTap: () {
                Get.back();
              },
            ),
            _CustomDrawerItem(
              icon: Icons.person_add_alt_1,
              label: "Add Visit",
              onTap: () => Get.toNamed(AppRoutes.addVisit),
            ),
            _CustomDrawerItem(
              icon: Icons.people_alt,
              label: "Add Meeting",
              onTap: () => Get.toNamed(AppRoutes.addMeeting),
            ),
          ],
        ),
      ),
    );
  }
}
