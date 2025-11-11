import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import '../../../data/services/api_manager.dart';
import '../../../data/services/storage_services.dart';
import '../../../data/user_get.dart';


class HomeSliderDrawer extends StatelessWidget {
  const HomeSliderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        backgroundColor: UColors.primary,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Obx(() {
                  final user = AuthService.to.user;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: (user?.profilePic != null && user!.profilePic!.isNotEmpty)
                            ? (user.profilePic!.startsWith("data:image")
                            ? MemoryImage(base64Decode(user.profilePic!.split(",").last))
                            : CachedNetworkImageProvider("${user.fullImageUrl}${user.profilePic!}"))
                            : const AssetImage(AppImages.addUser),

                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user?.name ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              user?.email ?? "",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),


              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
              color: Colors.blueAccent.withAlpha(50)),
              child:
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          UColors.primary.withAlpha(75),
                          UColors.primary,
                          Colors.blueAccent.shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: const Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(-4, -4),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: 12.w,),
                  Text("Home",style: TextStyle(color: UColors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded,color: UColors.white,size: 15,)
                ],
              ),
            ),
            _CustomDrawerItem(
              icon: Icons.verified_user,
              label: "Verification",
              hasArrow: true,
              onTap: () => Get.toNamed(AppRoutes.otpVerification),
            ),
            _CustomDrawerItem(
              icon: Icons.add_location_alt,
              label: "Add Visit",
              hasArrow: true,
              onTap: () => Get.toNamed(AppRoutes.addVisit),
            ),
            _CustomDrawerItem(
              icon: Icons.meeting_room,
              label: "Add Meeting",
              hasArrow: true,
              onTap: () => Get.toNamed(AppRoutes.addMeeting),
            ),
            _CustomDrawerItem(
              icon: Icons.group,
              label: "Team",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.account_balance,
              label: "Dispute Solution",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.people,
              label: "Associate",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.local_shipping,
              label: "Vehicle",
              hasArrow: true,
              onTap: () => Get.toNamed(AppRoutes.vehicleAdd),
            ),
            _CustomDrawerItem(
              icon: Icons.lightbulb,
              label: "Suggestion",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.insert_chart,
              label: "Report",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.settings,
              label: "Setting",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.notifications_active,
              label: "Vehicle Notification",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.article_outlined,
              label: "Notice Board",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.palette,
              label: "App Settings",
              hasArrow: true,
              onTap: () {
                Get.toNamed(AppRoutes.theme);
              },
            ),
            _CustomDrawerItem(
              icon: Icons.support_agent,
              label: "Support",
              hasArrow: true,
              onTap: () {},
            ),
            _CustomDrawerItem(
              icon: Icons.person,
              label: "Profile",
              hasArrow: true,
              onTap: () {},
            ),

        _CustomDrawerItem(
          icon: Icons.logout,
          label: "Logout",
          hasArrow: true,
          onTap: () {
            Get.dialog(
              Center(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.8, end: 1.0),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: UColors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: UColors.primary.withOpacity(0.3),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      UColors.primary.withAlpha(75),
                                      UColors.primary,
                                      Colors.blue.shade700,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                      offset: const Offset(4, 6),
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(-4, -4),
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.logout_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 10),

                               Text(
                                "Logout?",
                                style: TextStyle(
                                  color: UColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 10),
                               Text(
                                "Are you sure you want to logout from this account?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: UColors.black,
                                  fontSize: 16,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 25),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => Get.back(),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: UColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      shadowColor: UColors.primary.withOpacity(0.5),
                                      elevation: 8,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      StorageServices.to.logout();
                                    },
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              barrierColor: Colors.black.withOpacity(0.6),
              transitionCurve: Curves.easeInOut,
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),




    SizedBox(height: 10.h),
            Divider(color: Colors.white24),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Version: 1.0.0",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomDrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool hasArrow;

  const _CustomDrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: isHovered || kIsWeb
                      ? LinearGradient(
                    colors: [
                      UColors.primary.withAlpha(75),
                      UColors.primary,
                      Colors.blueAccent.shade700,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  boxShadow: isHovered || kIsWeb
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(-4, -4),
                    ),
                  ]
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isHovered || kIsWeb
                            ? LinearGradient(
                          colors: [
                            UColors.primary.withAlpha(75),
                            UColors.primary,
                            Colors.blueAccent.shade700,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : null,
                        boxShadow: isHovered || kIsWeb
                            ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(-2, -2),
                          ),
                        ]
                            : null,
                      ),
                      child: Icon(icon, color: Colors.white, size: 20.sp),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    if (hasArrow)
                      Icon(Icons.chevron_right_rounded,
                          color: Colors.white, size: 20.sp),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

