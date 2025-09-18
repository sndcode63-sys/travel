import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import '../../../../utlis/constents/colors.dart';
import '../../../../utlis/custom_widgets/custom_listview_builder.dart';
import 'aprroved_controller.dart';

class MeetingApprovedScreen extends StatelessWidget {
  const MeetingApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AprrovedController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value && controller.pendingMeetingList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value && controller.pendingMeetingList.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text("Retry"),
                )
              ],
            ),
          );
        }

        if (controller.pendingMeetingList.isEmpty) {
          return const Center(child: Text("No pending meetings"));
        }

        return CustomListView(
          itemCount: controller.pendingMeetingList.length,
          isMoreDataAvailable: controller.isMoreDataAvailable.value,
          onEndReached: controller.fetchPendingMeetings,
          itemBuilder: (context, index, item) {
            final meeting = controller.pendingMeetingList[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: UColors.white,
                border: Border.all(color: UColors.grey),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: "${meeting.fullImageUrl}${meeting.photo}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      memCacheWidth: 200,
                      memCacheHeight: 200,
                    ),
                  ),
                  15.w,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting.name ?? "",
                        style: const TextStyle(
                          color: UColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        meeting.schemeName ?? "",
                        style: const TextStyle(
                          color: UColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Submit Date: ${meeting.visitDate ?? ""}",
                        style: const TextStyle(
                          color: UColors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orangeAccent.withAlpha(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      meeting.visitStatus ?? "",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
