import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';
import '../../../data/services/storage_services.dart';
import 'slider_drawer_helper.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    AppStrings.demoTesting,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "test@gmail.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   margin: const EdgeInsets.only(bottom: 20),
            //   padding: const EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15.r),
            //     color: Colors.white.withAlpha(30),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         height: 40.h,
            //         width: 40.w,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15.r),
            //           color: Colors.blue.shade700,
            //         ),
            //         child: Icon(Icons.home_filled,size: 20.sp,color: UColors.white,),
            //       ),
            //       Text("Home",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20.sp),),
            //       IconButton(
            //         onPressed: () {},
            //         icon:  Icon(
            //           Icons.arrow_back_ios_rounded,
            //           color: Colors.white,
            //           size: 16.sp,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            DrawerMenuItem(
              icon: Icons.person,
              label: "Home",
              onTap: () {
                Get.toNamed(AppRoutes.addVisit);
              },
            ),
            DrawerMenuItem(
              icon: Icons.person,
              label: "Add Visit",
              onTap: () {
                Get.toNamed(AppRoutes.addVisit);
              },
            ),
            DrawerMenuItem(
              icon: Icons.meeting_room,
              label: "Add Meeting",
              onTap: () {
                Get.toNamed(AppRoutes.addMeeting);

              },
            ),
            DrawerMenuItem(icon: Icons.group, label: "Team", onTap: () {
              Get.toNamed(AppRoutes.teamScreen);

            }),
            DrawerMenuItem(
              icon: Icons.settings,
              label: "Setting",
              onTap: () {},
            ),
            DrawerMenuItem(
              icon: Icons.help,
              label: "Help & Support",
              onTap: () {},
            ),
            DrawerMenuItem(
              icon: Icons.campaign,
              label: "Notice Board",
              onTap: () {},
            ),
            DrawerMenuItem(icon: Icons.book, label: "Report", onTap: () {}),
            DrawerMenuItem(
              icon: Icons.phone_android,
              label: "App Settings",
              onTap: () {},
            ),
            DrawerMenuItem(
              icon: Icons.logout,
              label: "Logout",
              onTap: () {
                Get.dialog(
                  Center(
                    child: Material(
                      color: Colors.transparent,
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: AnimationController(
                            vsync: Navigator.of(Get.context!),
                            duration: const Duration(milliseconds: 300),
                          )..forward(),
                          curve: Curves.easeOutBack,
                        ),
                        child: Container(
                          width: Get.width * 0.8,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.95),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient:  LinearGradient(
                                    colors: [Colors.blue, UColors.primary],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:UColors.primary.withOpacity(0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.logout, color: Colors.white, size: 36),
                              ),
                              const SizedBox(height: 18),

                              // Title
                              const Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Subtitle
                              const Text(
                                "Are you sure you want to logout?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade200,
                                        foregroundColor: Colors.black87,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                      ),
                                      onPressed: () => Get.back(),
                                      child: const Text("Cancel"),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: UColors.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        StorageServices.to.logout();
                                      },
                                      child: const Text("Yes, Logout"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  barrierDismissible: true,
                );
              },
            ),

             Divider(height: 30.h, thickness: 1, color: Colors.white30),

            // 🔹 Footer Section
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Text(
                    "Designed & Developed by",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Glitchprobe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Version: 1.1.1",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

