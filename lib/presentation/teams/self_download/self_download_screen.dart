import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/teams/allDownline/all_downline_screen.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_controller.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_listview_builder.dart';

class SelfDownloadScreen extends StatelessWidget {
  const SelfDownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SelfController controller = Get.put(SelfController());

    return GestureDetector(
      onTap: (){
        hideKeyboard();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:  Size.fromHeight(70.h),
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
                            "My Team",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Self Downline", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Get.to(AllDownlineScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.blue.withOpacity(0.08),

            child: Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
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
                      enabledBorder: InputBorder.none,
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
                SizedBox(height: 5.h),

                /// 🔄 Loader / Error / List
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      /// Loader
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (controller.hasError.value) {
                      /// Error
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.errorMessage.value,
                              style: TextStyle(color: Colors.red, fontSize: 14.sp),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => controller.fetchUsers(),
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      );
                    }

                    if (controller.filteredSelf.isEmpty) {
                      /// Empty list case
                      return const Center(
                        child: Text("No associates found"),
                      );
                    }

                    /// ✅ Data Loaded
                    return CustomListView(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.filteredSelf.length,
                      itemBuilder: (context, index, item) {
                        final selfList = controller.filteredSelf[index];
                        return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: UColors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                            border: Border.all(color: UColors.grey),
                          ),
                          child: Row(
                            children: [
                              /// Avatar
                              Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: UColors.primary,
                                ),
                                child: Center(
                                  child: Text(
                                    controller.getFirstAndLastLetter(selfList.name),
                                    style: TextStyle(color: UColors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),

                              /// Labels
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: UColors.black)),
                                  Text("Code",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: UColors.black)),
                                  Text("Rera No.",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: UColors.black)),
                                ],
                              ),
                              SizedBox(width: 30.w),

                              /// Colon
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [Text(":"), Text(":"), Text(":")],
                              ),
                              SizedBox(width: 10.w),

                              /// Values
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selfList.name,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: UColors.black),
                                    ),
                                    Text(
                                      selfList.associateCode,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: UColors.primary),
                                    ),
                                    Text(
                                      selfList.reraNo ?? "N/A",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: UColors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          )

        ),
      ),
    );
  }
}
