import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import '../../../utlis/constents/img_constants.dart';
import '../../../utlis/constents/color_constants.dart';
import '../../../utlis/custom_widgets/custom_button.dart';
import 'otp_verification_controller.dart';

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpVerificationController());

    return GestureDetector(
      onTap: () => hideKeyboard(),
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(AppImages.otoBanner,height: 250,),
                      ),
                      SizedBox(height: 5.h),

                      // Success Message
                      Obx(() {
                        if (controller.otpMessage.value.isEmpty ||
                            controller.secondsRemaining.value == 0) {
                          return SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.green.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: Colors.green, size: 20),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    controller.otpMessage.value,
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                      // Title - Dynamic based on type
                      Align(
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                          controller.screenTitle,
                          style: TextStyle(
                            color: UColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      SizedBox(height: 5.h),

                      // Subtitle - Dynamic based on type
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Obx(() => Text(
                            controller.screenSubtitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      /// OTP Input
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: Pinput(
                            length: 6,
                            controller: controller.otpController,
                            showCursor: true,
                            obscureText: true,
                            obscuringCharacter: '*',
                            defaultPinTheme: PinTheme(
                              width: 56.w,
                              height: 56.h,
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .dividerColor
                                      .withAlpha(70),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            submittedPinTheme: PinTheme(
                              width: 56.w,
                              height: 56.h,
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onCompleted: (pin) {
                              controller.otpController.text = pin;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 22.h),

                      // Timer / Resend OTP
                      Obx(
                            () => Align(
                          alignment: Alignment.center,
                          child: controller.secondsRemaining.value > 0
                              ? Text(
                            "Resend OTP in ${controller.timerText}",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(0.7),
                              fontSize: 14.sp,
                            ),
                          )
                              : GestureDetector(
                            onTap: () => controller.onResendOtp(),
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// Verify Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(() => CustomButton(
                          backgroundColor: AppColors.primary,
                          text: controller.isLoading.value
                              ? "VERIFYING..."
                              : "VERIFY",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          isLoading: controller.isLoading.value,
                          onPressed: controller.onVerify,
                        )),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}