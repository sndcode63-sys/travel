import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';


class AddVisitScreen extends StatelessWidget {
  const AddVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddVisitController controller = Get.find<AddVisitController>();

    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 8.h,bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Get.back(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Add Visit",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Scheme List",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: Container(
              color: Colors.blue.withOpacity(0.08),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 15.h,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: UColors.white,
                        border: Border.all(color: UColors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(
                            color: Colors.black.withAlpha(75),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: UColors.primary),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        style: TextStyle(fontSize: 14, color: UColors.primary),
                      ),
                    ),
                    SizedBox(height: 15.h,),
                    Obx(() {
                      if (controller.currentAddress.value.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Detecting location...",
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    Expanded(child: SchemeList(controller: controller)),
                  ],
                ),
              ),
            ),
          )

        ),
      ),
    );
  }
}

class SchemeList extends StatelessWidget {
  const SchemeList({super.key, required this.controller});

  final AddVisitController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.filteredScheme.isEmpty) {
        return Center(child: Text('No schemes available'));
      }

      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: controller.filteredScheme.length,
        itemBuilder: (context, index) {
          final scheme = controller.filteredScheme[index];
          return InkWell(
            onTap: () {
              final pos = controller.currentPosition.value;
              final addr = controller.currentAddress.value;

              if (pos == null || addr.isEmpty) {
               controller.detectLocation();
                return;
              }

              Get.toNamed(
                AppRoutes.addMember,
                arguments: {
                  'id': scheme.id,
                  'name': scheme.schemeName,
                  'lat': pos.latitude,
                  'lng': pos.longitude,
                  'address': addr,
                },
              );

              print(
                '➡ Selected Scheme -> ID: ${scheme.id}, '
                    'Name: ${scheme.schemeName}, '
                    'Lat: ${pos.latitude}, Lng: ${pos.longitude}, Address: $addr',
              );
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: UColors.white,
                border: Border.all(color: UColors.grey, width: 1),
              ),
              child: Row(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.9, end: 1.0),
                    duration: Duration(milliseconds: 250),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: UColors.primary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.greenAccent.withAlpha(60),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              controller.getFirstAndLastLetter(
                                scheme.schemeName,
                              ),
                              style: TextStyle(
                                color: UColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 15.w,),
                  Expanded(
                    child: Text(
                      scheme.schemeName ?? '',
                      style: TextStyle(
                        fontSize: 16.h,
                        color: UColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
