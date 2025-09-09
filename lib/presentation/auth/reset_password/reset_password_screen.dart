import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/auth/reset_password/reset_passowrd_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import '../../../utlis/constents/app_sizes.dart';
import '../../../utlis/constents/color_constants.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ResetPassowrdController controller = Get.put(ResetPassowrdController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.adaptive.arrow_back, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      20.h,
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.dashBoard);
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            children: [
                              const TextSpan(text: "Hello! "),
                              TextSpan(
                                text: "Chart Group",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      8.h,
                      Text(
                        'Reset Your Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      30.h,

                      // New Password Field
                      Obx(() => AppTextField(
                        controller: controller.newPasswordController,
                        borderColor: Colors.grey.withOpacity(0.3),
                        hintText: "New Password",
                        focusedBorderColor: Colors.green,
                        obscureText: controller.obscureNew.value,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility,
                            color: AppColors.primary,
                          ),
                          onPressed: controller.toggleNew,
                        ),
                      )),
                      15.h,

                      // Confirm Password Field
      // Confirm Password Field
                      Obx(() => AppTextField(
                        controller: controller.confirmPasswordController,
                        borderColor: Colors.grey.withOpacity(0.3),
                        hintText: "Confirm New Password",
                        focusedBorderColor: Colors.green,
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
                      )),
                      Obx(() => controller.errorMessage.value.isNotEmpty
                          ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.errorMessage.value,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      )
                          : SizedBox.shrink()),
                      SizedBox(height: 20),
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
                    textColor: controller.isButtonEnabled.value
                        ? Colors.white
                        : AppColors.primary, // 👈 yaha change kiya
                    backgroundColor: controller.isButtonEnabled.value
                        ? AppColors.primary
                        : Colors.grey.withAlpha(100),
                    onPressed: controller.isButtonEnabled.value
                        ? () {
                    }
                        : null, // disabled state
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
