import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information_controller.dart';
import 'package:travell_booking_app/utlis/constents/color_constants.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';

class AddClientInformation extends GetView<AddClientInformationController> {
  const AddClientInformation({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.autoOpenCamera();
    });
    return Scaffold(
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
                /// Back Button + Title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.grey),
                      onPressed: () => Get.back(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "Add Visit",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Add Client Information",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// Settings Icon
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black54),
                  onPressed: () {
                    // Action here
                  },
                ),
              ],
            ),
          ),
        ),

      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            CustomButton(
              text: "SCHEME: AERO RESIDENCY",
              backgroundColor: AppColors.primary,
              fontWeight: FontWeight.w400,
              borderRadius: 15,
              fontSize: 16.sp,
              height: 50.h,
            ),
            SizedBox(height: 20.h,),
            Obx(() {
              return DottedBorder(
                color: Colors.grey,
                strokeWidth: 1,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: Container(
                  height: 310.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: controller.capturedImage.value == null
                      ?  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.grey, size: 40.sp),
                        SizedBox(height: 8.h),
                        Text(
                          "Click or Upload Selfie here",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(
                      controller.capturedImage.value!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: 20.h,),
            Obx(() {
              return CustomButton(
                text: "SAVE",
                isLoading: controller.isLoading.value,
                backgroundColor: AppColors.primary,
                onPressed: () {
                  controller.saveVisit();
                },
              );
            }),
            SizedBox(height: 50.h,),
          ],
        ),
      ),
    );
  }
}
