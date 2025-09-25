import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import '../widgets/common_bottom_sheet.dart';
import 'meeting_pending_controller.dart';

class MeetingPendingScreen
extends GetView<MeetingPendingController> {
  const MeetingPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MeetingPendingController controller = Get.put(MeetingPendingController());

    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.08),

      body: Obx(() {
        if (controller.isLoading.value && controller.pendingMeeting.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value && controller.pendingMeeting.isEmpty) {
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

        if (controller.pendingMeeting.isEmpty) {
          return const Center(child: Text("No visit found"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels >=
                scrollNotification.metrics.maxScrollExtent &&
                !controller.isLoading.value &&
                controller.isMoreDataAvailable.value) {
              controller.fetchPendingMeetings();
            }
            return false;
          },
          child: CustomListView(
            itemCount: controller.pendingMeeting.length,
            itemBuilder: (context, index, item) {
              final allListVisit = controller.pendingMeeting[index];


              return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      barrierColor: UColors.primary.withOpacity(0.3),
                      builder: (context) {
                        return buildBottomSheet(
                          title: "Visit",
                          imageUrl: "${allListVisit.fullImageUrl}${allListVisit.photo}",
                          date: allListVisit.submitDate ?? "",
                          time: allListVisit.submitTime ?? "",
                          status: allListVisit.visitStatus ?? "",
                          statusColor: Colors.orangeAccent,
                          description: allListVisit.reference ?? "",
                          numberOfUsers: allListVisit.noOfUser ?? 0,
                        );
                      },
                    );
                  },
                child: Container(
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
                              allListVisit.name ?? "N/A",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Description: ${allListVisit.reference ?? "N/A"}",
                              style: TextStyle(fontSize: 13.sp, color: UColors.primary),
                            ),
                            SizedBox(height: 2.h),

                            Text(
                              "Meeting Date: ${allListVisit.submitDate ?? ""}  ${allListVisit.submitTime}",
                              style: TextStyle(
                                fontSize: 11.sp,
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
                            color: Colors.orangeAccent
                                .withAlpha(40),
                          ),
                          child: Center(
                            child: Text(
                              allListVisit.visitStatus ?? "",
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              );
            },
          ),
        );
      }),
    );
  }
}
