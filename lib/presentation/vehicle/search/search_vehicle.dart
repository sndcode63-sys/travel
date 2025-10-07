import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../addVehicle/add_vehicle_controller.dart';

class SearchVehicle extends StatelessWidget {
  SearchVehicle({super.key});

  final AddVehicleController controller = Get.put(AddVehicleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        hideKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("My Complaints")),
        body: GestureDetector(
          onTap: hideKeyboard,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _searchBar(),
                const SizedBox(height: 20),

                Expanded(
                  child: Obx(() {
                    if (!controller.hasSearched.value) {
                      return const SizedBox.shrink();
                    }

                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!controller.hasData.value) {
                      return notSearchShow();
                    }

                    return ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(controller.searchResults[index]),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Enter min 3 digits of name / mobile number',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.searchData(controller.searchController.text);
              // Get.toNamed(AppRoutes.enterSummary);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(78),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.black, size: 20),
                  SizedBox(width: 6),
                  Text(
                    "Search",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notSearchShow() {
    return Center(
      child: DottedBorder(
        color: Colors.green,
        strokeWidth: 2,
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        padding: EdgeInsets.all(16.w),
        child: Container(
          width: 300.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "There is no data to show you right now.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
