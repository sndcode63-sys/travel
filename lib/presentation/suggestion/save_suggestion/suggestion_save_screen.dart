import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import '../../../utlis/custom_widgets/custom_text_field.dart';
import 'suggestion_save_controller.dart';
import 'dart:io';

class SuggestionSaveScreen extends StatelessWidget {
  const SuggestionSaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuggestionSaveController());

    String getFileName(File? file) {
      if (file == null) return "No file chosen";
      return file.path.split('/').last;
    }

    Widget buildUploadSection({
      required String title,
      required String buttonText,
      required VoidCallback onPressed,
      required IconData icon,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
          SizedBox(height: 8.h),
          Row(
            children: [
              GestureDetector(
                onTap: onPressed,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: UColors.grey),
                    color: UColors.lightGrey,
                    borderRadius: BorderRadius.circular(8.r),

                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: UColors.black, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        buttonText,
                        style: TextStyle(
                          color: UColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Obx(() => Text(
                  getFileName(controller.selectedFile.value),
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                )),
              ),
            ],
          ),
        ],
      );
    }

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
                            "Suggestion",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Documents Upload",
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
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                hintText: "Enter description...",
                labelText: "Description",
                maxLines: 6,
                showStar: true,
                controller: controller.descriptionController,
                validator: (val) =>
                val!.trim().isEmpty ? "Please enter description" : null,
              ),
              SizedBox(height: 25.h),

              buildUploadSection(
                title: "Upload Image",
                buttonText: "Choose File",
                icon: Icons.upload_file,
                onPressed: () {
                  controller.pickFile();
                },
              ),
              SizedBox(height: 16.h,),
              Divider(height: 0,thickness: 1,color: UColors.grey,),
              SizedBox(height: 60.h),

              Obx(() => CustomButton(
                text: controller.isLoading.value ? "Saving..." : "SAVE",
                backgroundColor: UColors.primary,
                isLoading: controller.isLoading.value,
                onPressed: controller.saveSuggestionForm,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
