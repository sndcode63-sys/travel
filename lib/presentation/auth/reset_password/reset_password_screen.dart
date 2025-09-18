import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/auth/reset_password/reset_passowrd_controller.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import '../../../utlis/constents/app_sizes.dart';
import '../../../utlis/constents/color_constants.dart';
import '../../../utlis/theme/widgets_theme/text_theme.dart';

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
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.adaptive.arrow_back,),
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
                        onTap: () {
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
                              const TextSpan(text: "Visit App "),
                              TextSpan(
                                text: AppStrings.demoTesting,
                                style: Theme.of(context).textTheme. bodyLarge,

                              ),
                            ],
                          ),
                        ),
                      ),
                      8.h,
                      Text(
                        'Reset Your Password',
                        style: Theme.of(context).textTheme. titleLarge,

                      ),
                      30.h,
                      Obx(
                        () => AppTextField(
                          controller: controller.newPasswordController,
                          hintText: "New Password",
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
                      15.h,

                      // Confirm Password Field
                      Obx(
                        () => AppTextField(
                          controller: controller.confirmPasswordController,
                          hintText: "Confirm New Password",
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
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                                : SizedBox.shrink(),
                      ),
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
                    textColor:
                        controller.isButtonEnabled.value
                            ? Colors.white
                            : AppColors.primary, // 👈 yaha change kiya
                    backgroundColor:
                        controller.isButtonEnabled.value
                            ? AppColors.primary
                            : Colors.grey.withAlpha(100),
                    onPressed:
                        controller.isButtonEnabled.value
                            ? () {
                      controller.onSubmit();
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
