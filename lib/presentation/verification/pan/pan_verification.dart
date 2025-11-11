import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/custom_widgets/custom_button.dart';
import '../../../utlis/custom_widgets/custom_text_field.dart';
import 'pan_verification_controller.dart';
import 'package:flutter/services.dart';



class PanVerification extends StatelessWidget {
  const PanVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PanVerificationController());

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
                      "Pan Verification",
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
                "Verify PAN Number",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Obx(() => AppTextField(
              controller: controller.panController,
              labelText: "PAN NUMBER",
              hintText: "Enter your PAN (e.g. ABCDE1234F)",
              showStar: true,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
              ],
              errorText: controller.panError.value.isEmpty
                  ? null
                  : controller.panError.value,
              onChanged: (val) => controller.panError.value = '',
            )),

            SizedBox(height: 40.h),

            Obx(() => CustomButton(
              text: controller.isLoading.value ? "SENDING..." : "VERIFY",
              backgroundColor: UColors.primary,
              onPressed:
              controller.isLoading.value ? null : controller.validatePan,
            )),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
