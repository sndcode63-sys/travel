import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/complaine/disputSummary/dispute_enter_summary_controller.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

class DisputeEnterSummary extends GetView<DisputeEnterSummaryController> {
  const DisputeEnterSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
     final staffId = args?['id'] ?? '';

    return Scaffold(
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
                            "Entre Dispute Summary",
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
      ),      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              AppTextField(
                hintText: "Subject",
                labelText: "Subject",
                showStar: true,
                controller: controller.subjetController,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                hintText: "Description",
                labelText: "Description",
                showStar: true,
                controller: controller.descriptionController,

              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomAppBar(
        child:Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: UColors.primary),
          onPressed: (){
            controller.saveDispute(staffId);
          },
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
            "UPDATE",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ))
      ),
    );
  }
}
