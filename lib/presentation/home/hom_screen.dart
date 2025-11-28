import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/auth/otp/otp_verification_screen.dart';
import 'package:travell_booking_app/presentation/profileCenter/profile_center_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import '../../data/services/api_manager.dart';
import '../../main.dart';
import 'home_controller.dart';
import 'wigets/home_slider_drawer.dart';

class HomScreen extends StatelessWidget {
  HomScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController controller = Get.put(HomeController());
  final ProfileCenterController profileCenterController =
  Get.put(ProfileCenterController());



  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: UColors.white,
        drawer:  CustomDrawer(),
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: UColors.primary,
          toolbarHeight: 70.h,
          leadingWidth: 60,
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SvgPicture.asset(AppImages.menuIcon, height: 15, width: 15),
            ),
          ),
          title:Obx(() {
            final user = AuthService.to.userData.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user?.name ?? "",
                  style: TextStyle(
                    color: UColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  user?.email ?? "",
                  style: TextStyle(
                    color: UColors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            );
          }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications_rounded,
                color: UColors.white,
                size: 22.sp,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white, size: 22.sp),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
          ],
        ),

        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(AppImages.bacGround, fit: BoxFit.cover),
            ),

            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 30.h),
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
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      }

                      final PageController pageController = PageController();
                      final ValueNotifier<int> currentIndex = ValueNotifier(0);
                      int currentPage = 0;

                      Timer.periodic(const Duration(seconds: 3), (timer) {
                        if (pageController.hasClients &&
                            sliderImages.isNotEmpty) {
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
                        height: 200.sp,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: pageController,
                              onPageChanged:
                                  (index) => currentIndex.value = index,
                              itemCount: sliderImages.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
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
                                        (context, url, error) => const Center(
                                          child: Icon(Icons.error),
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
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
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
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
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

                    SizedBox(height: 16.h),
                    CustomIconGridSection(
                      title: "Visit / Meeting",
                      items: [
                        IconItem(
                          iconPath: AppImages.addVisit,
                          title: 'Add Visit',
                          color: Colors.orange,
                          onTap: () {
                            Get.toNamed(AppRoutes.addVisit);
                          },
                        ),
                        IconItem(
                          iconPath: AppImages.visit,
                          title: 'Visit List',
                          color: Colors.cyan,
                          padding: 14,
                          onTap: () {
                            Get.toNamed(AppRoutes.visitList);
                          },
                        ),
                        IconItem(
                          iconPath: AppImages.meeting,
                          title: 'Add Meeting',
                          color: Colors.purple,
                          onTap: () {
                            Get.toNamed(AppRoutes.addMeeting);
                          },
                        ),
                        IconItem(
                          iconPath: AppImages.meetingList,
                          title: 'Meeting List',
                          color: Colors.blue,
                          onTap: () {
                            Get.toNamed(AppRoutes.meetingList);
                          },
                        ),
                      ],
                    ),
                    ActivitySection(
                      title: "Downline Team",
                      items: [
                        ActivityItem(
                          label: 'Team',
                          icon: AppImages.teams,
                          color: const Color(0xFFE91E63),
                          route: AppRoutes.teamScreen,
                        ),
                        ActivityItem(
                          label: 'Self Downline',
                          icon: AppImages.selfDownline,
                          color: const Color(0xFF00BCD4),
                          route: AppRoutes.selfDownline,
                        ),
                        ActivityItem(
                          label: 'All Downline',
                          icon: AppImages.allDownline,
                          color: const Color(0xFF3F51B5),
                          route: AppRoutes.allDowline,
                        ),
                      ],
                    ),
                    ActivitySection(
                      title: "Associate Info",
                      items: [
                        ActivityItem(
                          label: 'Add Associate',
                          icon: AppImages.addSuggestion,
                          color: const Color(0xFFE91E63),
                          route: AppRoutes.addAssociate,

                        ),
                        ActivityItem(
                          label: 'My Associate',
                          icon: AppImages.addSuggestion,
                          color: const Color(0xFF00BCD4),
                          route: AppRoutes.associateTab,

                        ),
                        ActivityItem(
                          label: 'Downline',
                          icon: AppImages.addVehicle,
                          color: const Color(0xFF3F51B5),
                          route: AppRoutes.vehicleAdd,
                        ),
                      ],
                    ),
                    ActivitySection(
                      title: "Complaint / Dispute",
                      items: [
                        ActivityItem(
                          label: 'Raise Complaint',
                          icon: AppImages.raisign,
                          color: const Color(0xFFE91E63),
                          route: AppRoutes.complainDispute,
                        ),
                        ActivityItem(
                          label: 'My Complaint',
                          icon: AppImages.addSuggestion,
                          color: const Color(0xFF00BCD4),
                          route: AppRoutes.myComplain1,
                        ),
                        ActivityItem(
                          label: 'Complaint With Me',
                          icon: AppImages.hand,
                          color: const Color(0xFF3F51B5),
                          route: AppRoutes.myComplainWithMe,

                        ),
                      ],
                    ),
                    ActivitySection(
                      title: "Vehicle",
                      items: [
                        ActivityItem(
                          label: 'Add Vehicle',
                          icon: AppImages.addVehicle,
                          color: const Color(0xFFE91E63),
                          route: AppRoutes.vehicleAdd,
                        ),
                        ActivityItem(
                          label: 'My Vehicle',
                          icon: AppImages.vehicleList,
                          color: const Color(0xFF00BCD4),
                          route: AppRoutes.vehicleR,
                        ),
                        ActivityItem(
                          label: 'Search Vehicle',
                          icon: AppImages.searchVehicle,
                          color: const Color(0xFF3F51B5),
                          route: AppRoutes.searchVehicle,
                        ),
                      ],
                    ),

                    ActivitySection(
                      title: "Other Activity",
                      items: [
                        ActivityItem(
                          label: 'Add Suggestion',
                          icon: AppImages.addSuggestion,
                          color: const Color(0xFFE91E63),
                          route: AppRoutes.saveSuggestion,
                        ),
                        ActivityItem(
                          label: 'Suggestion List',
                          icon: AppImages.suggestionList,
                          color: const Color(0xFF00BCD4),
                          route: AppRoutes.suggestionListScreen,
                        ),
                        ActivityItem(
                          label: 'Library',
                          icon: AppImages.library,
                          color: const Color(0xFF3F51B5),
                          route: AppRoutes.library,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopMenu(String iconPath, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SvgPicture.asset(iconPath, height: 28, width: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

}

class CustomAppBarExample extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarExample({super.key});

  @override
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: UColors.primary,
      child: Center(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(Icons.menu, color: UColors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Obx(() {
              final user = AuthService.to.userData.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.name ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    user?.email ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              );
            }),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
                size: 26.sp,
              ),
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

class ActivityItem {
  final String label;
  final String icon;
  final Color color;
  final String? route;

  ActivityItem({
    required this.label,
    required this.icon,
    required this.color,
    this.route,
  });
}

class ActivitySection extends StatelessWidget {
  final String title;
  final List<ActivityItem> items;
  final bool showBackground;

  const ActivitySection({
    super.key,
    required this.title,
    required this.items,
    this.showBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(showBackground ? 16.w : 0),
        decoration: BoxDecoration(
          color: showBackground ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: showBackground
              ? [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.map((item) {
                return InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () {
                    if (item.route != null) {
                      Get.toNamed(item.route!);
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: BoxDecoration(
                          color: UColors.primary,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            item.icon,
                            width: 40.w,
                            height: 40.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: 60.h,
                        child: Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,

                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIconGridSection extends StatelessWidget {
  final String title;
  final List<IconItem> items;

  const CustomIconGridSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) => _buildItem(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            padding: EdgeInsets.all(item.padding ?? 12),
            decoration: BoxDecoration(
              color: UColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              item.iconPath,
              width: item.iconSize ?? 28,
              height: item.iconSize ?? 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class IconItem {
  final String iconPath;
  final String title;
  final Color color;
  final double? padding;
  final double? iconSize;
  final VoidCallback? onTap;

  IconItem({
    required this.iconPath,
    required this.title,
    required this.color,
    this.padding,
    this.iconSize,
    this.onTap,
  });
}
