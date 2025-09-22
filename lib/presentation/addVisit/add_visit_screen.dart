import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';

class AddVisitScreen extends StatelessWidget {
  final AddVisitController controller = Get.put(AddVisitController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration:  BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.r,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            "Add Visit",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Scheme List", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Get.toNamed(AppRoutes.meetingList);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
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
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: UColors.primary),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: TextStyle(fontSize: 14.sp, color: UColors.primary),
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                    },
                  ),
                ),
                SizedBox(height: 10.h,),
                Expanded(child: SchemeList(controller: controller)),
              ],
            ),
          ),
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
              Get.toNamed(
                AppRoutes.addMember,
                arguments: {'id': scheme.id, 'name': scheme.schemeName},
              );
              print(
                '➡ Selected Scheme -> ID: ${scheme.id}, Name: ${scheme.schemeName}',
              );
            },
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
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
                            gradient: LinearGradient(
                              colors: [
                                Colors.greenAccent.withAlpha(180),
                                Colors.green.withAlpha(120),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
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
                                color: UColors.primary,
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
