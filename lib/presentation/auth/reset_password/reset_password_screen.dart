import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/auth/reset_password/reset_passowrd_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import '../../../utlis/constents/app_sizes.dart';
import '../../../utlis/constents/color_constants.dart';
import '../../../utlis/constents/img_constants.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPassowrdController controller = Get.put(
      ResetPassowrdController(),
    );

    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.08),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.adaptive.arrow_back),
          ),
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: Container(
              color: Colors.blue.withOpacity(0.08),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(AppImages.resetPassword),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.dashBoard);
                            },
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Set Your Password ",
                                    style: TextStyle(
                                      color: UColors.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Reset Your Password',
                            style: TextStyle(
                              color: UColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 35.h),
                          Obx(
                            () => AppTextField(
                              controller: controller.newPasswordController,
                              hintText: "New Password",
                              labelText:"New Password",
                              obscureText: controller.obscureNew.value,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: AppColors.primary,
                                ),
                                onPressed: controller.toggleNew,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Obx(
                            () => AppTextField(
                              controller: controller.confirmPasswordController,
                              hintText: "Confirm New Password",
                              labelText:"Confirm New Password",

                              obscureText: controller.obscureConfirm.value,
                              obscuringCharacter: '*',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscureConfirm.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: controller.toggleConfirm,
                              ),
                            ),
                          ),
                          Obx(
                            () =>
                                controller.errorMessage.value.isNotEmpty
                                    ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        controller.errorMessage.value,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    )
                                    : SizedBox.shrink(),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),

                  // Save Button
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Obx(
                      () => CustomButton(
                        text: "SAVE",
                        textColor:
                            controller.isButtonEnabled.value
                                ? Colors.white
                                : AppColors.primary,
                        backgroundColor:
                            controller.isButtonEnabled.value
                                ? AppColors.primary
                                : Colors.grey.withAlpha(100),
                        onPressed:
                            controller.isButtonEnabled.value
                                ? () {
                                  controller.onSubmit();
                                }
                                : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
