import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_controller.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            "Add Meeting",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Meeting List", style: TextStyle(fontSize: 14.sp)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.black54),
                    onPressed: () {},
                  ),
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
                    SizedBox(height: 30.h,),
                    AppTextField(
                      hintText: 'Number Of Users',
                      labelText: 'Number Of Users',
                      controller: controller.numberOfUsersController,
                      validator: controller.validateNumberOfUsers,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20.h,),
                    AppTextField(
                      hintText: 'Reference',
                      labelText: 'Reference',
                      controller: controller.referenceController,
                      validator: controller.validateReference,
                      keyboardType: TextInputType.text,
                    ),

                    SizedBox(height: 30.h,),
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
                          child:
                              controller.capturedImage.value == null
                                  ?  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Colors.grey,
                                          size: 40.sp,
                                        ),
                                        SizedBox(height: 8.h),
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
                    SizedBox(height: 25.h,),
                    Obx(() => CustomButton(
                      text: 'SAVE',
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        controller.saveForm();
                      },
                      isLoading: controller.isLoading.value,
                    )),
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
