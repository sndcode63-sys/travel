import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information_controller.dart';
import 'package:travell_booking_app/utlis/constents/color_constants.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

class AddClientInformation extends GetView<AddClientInformationController> {
  const AddClientInformation({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.autoOpenCamera();
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
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
                      onPressed: () => Navigator.pop(context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Add Visit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Add Client Information",
                          style: TextStyle(
                            fontSize: 14,
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
            20.h,
            CustomButton(
              text: "SCHEME: AERO RESIDENCY",
              backgroundColor: AppColors.primary,
              fontWeight: FontWeight.w400,
              borderRadius: 15,
              fontSize: 16,
              height: 50,
            ),
            20.h,
            Obx(() {
              return DottedBorder(
                color: Colors.grey,
                strokeWidth: 1,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: Container(
                  height: 310,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: controller.capturedImage.value == null
                      ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.grey, size: 40),
                        SizedBox(height: 8),
                        Text(
                          "Click or Upload Selfie here",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      controller.capturedImage.value!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            }),

            20.h,
            CustomButton(
              text: "SAVE",
              backgroundColor: AppColors.primary,
              onPressed: () {
                controller.saveVisit();
              },
            ),
            50.h,
          ],
        ),
      ),
    );
  }
}
