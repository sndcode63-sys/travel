import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'complain_with_me_controller.dart';
import 'complain_with_me_screen.dart';

class ComplainWithMe extends StatelessWidget {
  ComplainWithMe({super.key});

  final ComplainWithMeController controller = Get.put(ComplainWithMeController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
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
                              "Complaint / Dispute",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Complain With Me Data",
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
        body: GestureDetector(
          onTap: hideKeyboard,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!controller.hasData.value) {
                    }

                    return ListView.builder(
                      itemCount: controller.disputeList.length,
                      itemBuilder: (context, index) {
                        final item = controller.disputeList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ComplainWithMeScreen(),
                              arguments: item,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.subject ?? "No Subject",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 6),
                                Text("From: ${item.fromName ?? '-'}"),
                                Text("To: ${item.toName ?? '-'}"),
                                Text("Status: ${item.lastStatus ?? '-'}",
                                    style: TextStyle(color: Colors.blue)),
                                SizedBox(height: 4),
                                Text("Date: ${item.disputeDate ?? '-'}",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        );

                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
