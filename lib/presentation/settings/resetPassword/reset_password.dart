import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';

import 'reset_password_controller.dart';

class ResetPassword extends GetView<ResetPasswordController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
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
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Reset Password',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.black54,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.blue.withOpacity(0.08),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Change Your Password",
                      style: TextStyle(
                        color: UColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    hintText: "Old Password",
                    labelText: "Old Password",
                    controller: controller.oldPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 20.h),

                  AppTextField(
                    hintText: "New Password",
                    labelText: "New Password",
                    controller: controller.newPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 20.h),

                  AppTextField(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                  ),

                  SizedBox(height: 70.h,),
                  Obx(() => CustomButton(
                    text: controller.isLoading.value ? "Saving..." : "Save",
                    backgroundColor: controller.isButtonEnabled.value ? UColors.primary : UColors.grey,
                    textColor: Colors.white,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.isButtonEnabled.value ? controller.onSubmit : null,
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
