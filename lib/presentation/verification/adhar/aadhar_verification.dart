import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_button.dart';
import '../../../utlis/custom_widgets/custom_text_field.dart';
import 'adhar_verification_controller.dart';

class AadharVerification extends StatelessWidget {
  const AadharVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdharVerificationController());

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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Text(
                      "Aadhar Verification",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            Center(
              child: Text(
                "Verify Aadhaar Number",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Obx(() => AppTextField(
              controller: controller.aadharController,
              labelText: "AADHAAR NUMBER",
              hintText: "Enter your Aadhaar (12 digits)",
              showStar: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
                FilteringTextInputFormatter.digitsOnly,
              ],
              errorText: controller.aadharError.value.isEmpty
                  ? null
                  : controller.aadharError.value,
              onChanged: (val) => controller.aadharError.value = '',
            )),

            SizedBox(height: 40.h),

            Obx(() => CustomButton(
              text: controller.isLoading.value ? "VERIFYING..." : "VERIFY",
              backgroundColor: UColors.primary,
              onPressed: controller.isLoading.value ? null : controller.validateAadhar,
            ))
          ],
        ),
      ),
    );
  }
}
