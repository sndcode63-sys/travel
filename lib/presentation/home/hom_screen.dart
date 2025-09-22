import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/home/wigets/other_activity.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';
import '../../utlis/custom_widgets/custom_text.dart';
import 'home_controller.dart';
import 'wigets/downline_list.dart';
import 'wigets/home_list.dart';
import 'wigets/home_slider_drawer.dart';
import 'wigets/report_list.dart';

class HomScreen extends StatelessWidget {
  const HomScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      drawer: const HomeSliderDrawer(),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: UColors.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder:
                  (context) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: UColors.white,
                    ),
                    height: 48.h,
                    width: 48.w,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: UColors.primary),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.demoTesting,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                ),
                Text(
                  "test@gmail.com",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            actions: [
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
      ),
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
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.grey.shade200,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
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
              HomeList(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomText(
                  text: "Report List",
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.sp),
              ReportList(),
              SizedBox(height: 20.sp),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomText(
                  text: "Downline Team",
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.sp),
              DownlineList(),
              SizedBox(height: 20.sp),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomText(
                  text: "Other Activity",
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.sp),
              OtherActivity(),
              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
