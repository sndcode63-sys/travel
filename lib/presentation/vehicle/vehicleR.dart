import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import '../../utlis/constents/colors.dart';
import 'vehicleList/widgets/custom_tab_bar.dart';
import 'vehicleR_controller.dart';

class Vehicler extends StatelessWidget {
  const Vehicler({super.key});
  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(VehiclerController());
    final TextEditingController textController = TextEditingController();
    return GestureDetector(
      onTap: (){
        hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
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
                              "Vehicle",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "vehicle list",
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
        body: Container(
          color: UColors.white,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Search Bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: UColors.grey),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey, size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        onChanged: (value) {
                          searchController.updateSearch(value);
                        },
                        style: TextStyle(fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'Search by Registration/Model/Brand/Color',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                          isDense: true,
                        ),
                      ),
                    ),
                    Obx(() {
                      if (searchController.searchQuery.value.isNotEmpty) {
                        return IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey, size: 18.sp),
                          onPressed: () {
                            textController.clear();
                            searchController.clearSearch();
                          },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        );
                      }
                      return SizedBox.shrink();
                    }),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(child: CustomVehicleTabs()),
            ],
          ),
        ),
      ),
    );
  }
}