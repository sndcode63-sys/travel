import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';
import 'home_controller.dart';
import 'wigets/custom_item.dart';
import 'wigets/home_slider_drawer.dart';

class HomScreen extends StatelessWidget {
  const HomScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.08),
      drawer: const HomeSliderDrawer(),
      appBar: const CustomAppBarExample(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {

                final sliderImages =
                    controller.slider
                        .map((e) => e.fullImageUrl)
                        .where((url) => url.isNotEmpty)
                        .toList();
        
                if (sliderImages.isEmpty) {
                  return SizedBox(
                    height: 220.sp,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
        
                final PageController pageController = PageController();
                final ValueNotifier<int> currentIndex = ValueNotifier(0);
                int currentPage = 0;
        
                Timer.periodic(const Duration(seconds: 3), (timer) {
                  if (pageController.hasClients && sliderImages.isNotEmpty) {
                    currentPage++;
                    if (currentPage >= sliderImages.length) currentPage = 0;
                    pageController.animateToPage(
                      currentPage,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                });
        
                return SizedBox(
                  height: 220.sp,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: pageController,
                        onPageChanged: (index) => currentIndex.value = index,
                        itemCount: sliderImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: sliderImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                placeholder:
                                    (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget:
                                    (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 30.h,
                        left: 0.w,
                        right: 0.w,
                        child: ValueListenableBuilder<int>(
                          valueListenable: currentIndex,
                          builder: (context, value, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(sliderImages.length, (
                                dotIndex,
                              ) {
                                final isActive = value == dotIndex;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                  ),
                                  height: 8.sp,
                                  width: isActive ? 20.sp : 8.sp,
                                  decoration: BoxDecoration(
                                    color:
                                        isActive
                                            ? UColors.primary
                                            : Colors.white54,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 20.h),
              DashboardSection(
                title: " Visit / Meeting",
                items: [
                  DashboardItem(
                    label: "Add Visit",
                    assetPath: AppImages.addVisit,
                    onTap: () => Get.toNamed(AppRoutes.addVisit),
                  ),
                  DashboardItem(
                    label: "Add Meeting",
                    assetPath: AppImages.meeting,
                    onTap: () => Get.toNamed(AppRoutes.addMeeting),
                  ),
                  DashboardItem(
                    label: "Library",
                    assetPath: AppImages.library,
                    onTap: () => Get.toNamed(AppRoutes.library),
                  ),
                  // DashboardItem(label: "Plot", assetPath: AppImages.addVisit),
                ],
              ),
              SizedBox(height: 20.h),
              DashboardSection(
                title: "Report List",
                items: [
                  DashboardItem(
                    label: "Visit",
                    assetPath: AppImages.addVisit,
                    onTap: () => Get.toNamed(AppRoutes.visitList),
                  ),
                  DashboardItem(
                    label: "Meeting",
                    assetPath: AppImages.selfDownline,
                    onTap: () => Get.toNamed(AppRoutes.meetingList),
                  ),
                  DashboardItem(label: "Sales", assetPath: AppImages.addVisit),
                ],
              ),
              SizedBox(height: 20.h),
              DashboardSection(
                title: "Downline",
                items: [
                  DashboardItem(
                    label: "Team",
                    assetPath: AppImages.teams,
                    onTap: () => Get.toNamed(AppRoutes.teamScreen),
                  ),
                  DashboardItem(
                    label: "Self Downline",
                    assetPath: AppImages.selfDownline,
                    onTap: () => Get.toNamed(AppRoutes.selfDownline),
                  ),
                  DashboardItem(
                    label: "All Downline",
                    assetPath: AppImages.addVisit,
                    onTap: () => Get.toNamed(AppRoutes.allDowline),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              DashboardSection(
                title: "Complaint/Dispute",
                items: [
                  DashboardItem(
                    label: "Raise Complaint",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "My Complaint",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "Complaint With Me",
                    assetPath: AppImages.addVehicle,
                  ),
        
                ],
              ),
              SizedBox(height: 20.h),
              DashboardSection(
                title: "Associate Info",
                items: [
                  DashboardItem(
                    label: "Add Associate",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "My Associate",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "Downline",
                    assetPath: AppImages.addVehicle,
                  ),
        
                ],
              ),
              SizedBox(height: 20.h),
              DashboardSection(
                title: "Vehicle",
                items: [
                  DashboardItem(
                    label: "Add Vehicle",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "My Vehicle",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "Search Vehicle",
                    assetPath: AppImages.addVehicle,
                  ),
        
                ],
              ),
              SizedBox(height: 20.h),
              DashboardSection(
                title: "Other Activity",
                items: [
                  DashboardItem(
                    label: "Add Suggestion",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "Suggestion List",
                    assetPath: AppImages.addVisit,
                  ),
                  DashboardItem(
                    label: "Library",
                    assetPath: AppImages.addVehicle,
                  ),
        
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomAppBarExample extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarExample({super.key});

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: UColors.primary,
      child: Center(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Icon(Icons.menu, color: UColors.primary, size: 20.sp),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.demoTesting,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp),
                ),
                Text(
                  "test@gmail.com",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.notifications_rounded, color: Colors.white, size: 26.sp),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white, size: 26.sp),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
