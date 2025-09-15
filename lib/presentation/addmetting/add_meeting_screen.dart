import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_controller.dart';
import 'package:travell_booking_app/presentation/addmetting/widgets/add_meeting_widgets.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';
import '../../utlis/constents/color_constants.dart';
import '../../utlis/custom_widgets/custom_text_field.dart';

class AddMeetingScreen extends GetView<AddMeetingController> {
  const AddMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMeetingController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.autoOpenCamera();
    });

    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Add Meeting", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Meeting List", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(icon: const Icon(Icons.settings, color: Colors.black54), onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    20.h,
                    AppTextField(
                      hintText: 'Number Of Users',
                      labelText: 'Number Of Users',
                      controller: controller.numberOfUsersController,
                      validator: controller.validateNumberOfUsers,
                      keyboardType: TextInputType.number,

                    ),
                    AppTextField(
                      hintText: 'Reference',
                      labelText: 'Reference',
                      controller: controller.referenceController,
                      validator: controller.validateReference,
                      keyboardType: TextInputType.text,

                    ),

                    30.h,
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
                                Text("Click or Upload Selfie here", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(controller.capturedImage.value!, fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                      );
                    }),
                    30.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera_front, color: AppColors.primary),
                                      title: const Text("Capture with Front Camera"),
                                      onTap: () {
                                        controller.captureImage(true);
                                        Get.back();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_rear, color: AppColors.primary),
                                      title: const Text("Capture with Back Camera"),
                                      onTap: () {
                                        controller.captureImage(false);
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Capture Visit Image",
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.pickFromGallery(),
                          child: const Text(
                            "Upload Image",
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    25.h,
                    CustomButton(
                      text: 'SAVE',
                      backgroundColor: AppColors.primary,
                      onPressed: () => controller.saveForm(), // triggers full validation
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
