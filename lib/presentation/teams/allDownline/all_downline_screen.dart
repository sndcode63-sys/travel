import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import '../self_download/self_download_screen.dart';
import 'all_downline_controller.dart';

class AllDownlineScreen extends StatelessWidget {
  const AllDownlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllDownlineController controller = Get.put(AllDownlineController());

    return Scaffold(
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
                            "My Team",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "All Downline",
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
        child: Container(
          color: Colors.blue.withOpacity(0.08),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              // 🔍 Search Box
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: UColors.white,
                  border: Border.all(color: UColors.grey),
                  boxShadow: [
                    const BoxShadow(
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
                  onChanged: (value) => controller.searchQuery.value = value,
                ),
              ),

              SizedBox(height: 5.h),

              // 🧾 List Section
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.hasError.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.errorMessage.value,
                            style: TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => controller.fetchUsers(),
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  }

                  // ✅ Use filteredSelf instead of allDownline
                  if (controller.filteredSelf.isEmpty) {
                    return const Center(
                      child: Text("No associates found"),
                    );
                  }

                  return CustomListView(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.filteredSelf.length,
                    itemBuilder: (context, index, item) {
                      final allListD = controller.filteredSelf[index];
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
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: UColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  controller.getFirstAndLastLetter(allListD.name),
                                  style: TextStyle(color: UColors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildRow("Name", allListD.name ?? ""),
                                  _buildRow("Code", allListD.associateCode ?? ""),
                                  _buildRow("Rera No.", allListD.reraNo ?? "N/A"),
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
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: TextStyle(
              color: UColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Text(": "),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: title == "Code" ? UColors.primary : UColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
