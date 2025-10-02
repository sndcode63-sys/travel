import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/models/visitList/visit_list.dart';
import '../../../../utlis/constents/colors.dart';
import '../../../../utlis/custom_widgets/custom_listview_builder.dart';
import 'visit_all_controller.dart';
import 'wigets/cuatom_widgets.dart';

class VisitAllScreen extends GetView<VisitAllController> {
  const VisitAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VisitAllController controller = Get.put(VisitAllController());
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.08),
      body: Obx(() {
        if (controller.isLoading.value && controller.allMeetingList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.hasError.value && controller.allMeetingList.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.errorMessage.value),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        if (controller.allMeetingList.isEmpty) {
          return const Center(child: Text("No visit found"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels >=
                    scrollNotification.metrics.maxScrollExtent &&
                !controller.isLoading.value &&
                controller.isMoreDataAvailable.value) {
              controller.fetchUsers();
            }
            return false;
          },
          child: CustomListView(
            itemCount: controller.allMeetingList.length + 1,
            itemBuilder: (context, index, item) {
              if (index == controller.allMeetingList.length) {
                if (controller.isMoreDataAvailable.value) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }

              final allListVisit = controller.allMeetingList[index];

              return GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              width: 40.h,
                              height: 5.w,
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Client Name: ${allListVisit.name}',
                                style: TextStyle(
                                  color: UColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.sp,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${allListVisit.fullImageUrl}${allListVisit.photo}",
                                  height: 320.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Visit Date",
                                        style: TextStyle(
                                          color: UColors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        "${allListVisit.visitDate} ${allListVisit.submitTime}",
                                        style: TextStyle(
                                          color: UColors.darkerGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 8.h,),
                                  Divider(height: 0,thickness: 1,color:UColors.grey,),
                                  SizedBox(height: 8.h,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Status",
                                        style: TextStyle(
                                          color: UColors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: controller.getStatusColor(allListVisit.visitStatus).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          allListVisit.visitStatus ?? "",
                                          style: TextStyle(
                                            color: controller.getStatusColor(allListVisit.visitStatus),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )                                    ],
                                  ),
                                  SizedBox(height: 8.h,),
                                  Divider(height: 0,thickness: 1,color:UColors.grey,),
                                  SizedBox(height: 8.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Email ",
                                        style: TextStyle(
                                          color: UColors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        allListVisit.email ?? "",
                                        style: TextStyle(
                                          color: UColors.darkerGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h,),
                                  Divider(height: 0,thickness: 1,color:UColors.grey,),
                                  SizedBox(height: 20.h,),  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Project Name ",
                                        style: TextStyle(
                                          color: UColors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        allListVisit.schemeName ?? "",
                                        style: TextStyle(
                                          color: UColors.darkerGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h,),
                                  Divider(height: 0,thickness: 1,color:UColors.grey,),
                                  SizedBox(height: 20.h,),  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Father Name ",
                                        style: TextStyle(
                                          color: UColors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        allListVisit.fatherName ?? "",
                                        style: TextStyle(
                                          color: UColors.darkerGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h,),
                                  Divider(height: 0,thickness: 1,color:UColors.grey,),
                                  SizedBox(height: 20.h,),  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Contact ",
                                        style: TextStyle(
                                          color: UColors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        allListVisit.phone ?? "",
                                        style: TextStyle(
                                          color: UColors.darkerGrey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h,),
                                  Divider(height: 0,thickness: 1,color:UColors.grey,),
                                  SizedBox(height: 20.h,),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: allListCard(
                  allListVisit: allListVisit,
                  controller: controller,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class allListCard extends StatelessWidget {
  const allListCard({
    super.key,
    required this.allListVisit,
    required this.controller,
  });

  final VisitList allListVisit;
  final VisitAllController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: UColors.white,
        border: Border.all(color: UColors.grey),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // sab vertically center me
        children: [
          /// Avatar / Image
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: "${allListVisit.fullImageUrl}${allListVisit.photo}",
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              memCacheWidth: 200,
              memCacheHeight: 200,
            ),
          ),

          SizedBox(width: 15.w),

          /// Name + Scheme + Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center, // 👈 text vertically center hoga
              children: [
                Text(
                  allListVisit.name ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Project: ${allListVisit.schemeName ?? "N/A"}",
                  style: TextStyle(fontSize: 13.sp, color: UColors.primary),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Visit Date: ${allListVisit.visitDate ?? ""} ${allListVisit.submitTime}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: UColors.greyDark.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),

          /// Status Badge
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Container(
              height: 24.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: controller
                    .getStatusColor(allListVisit.visitStatus)
                    .withAlpha(40),
              ),
              child: Center(
                child: Text(
                  allListVisit.visitStatus ?? "",
                  style: TextStyle(
                    color: controller.getStatusColor(allListVisit.visitStatus),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
