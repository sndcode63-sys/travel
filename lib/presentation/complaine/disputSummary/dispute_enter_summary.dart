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
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complaint/Dispute",
              style: TextStyle(
                color: UColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Enter Dispute Summary",
              style: TextStyle(
                color: UColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),

      ),
      body: SingleChildScrollView(
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
