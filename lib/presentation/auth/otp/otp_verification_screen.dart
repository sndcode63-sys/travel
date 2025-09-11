import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import '../../../utlis/app_routes.dart';
import '../../../utlis/constents/app_sizes.dart';
import '../../../utlis/constents/color_constants.dart';
import '../../../utlis/constents/img_constants.dart';
import '../../../utlis/custom_widgets/custom_button.dart';
import '../../../utlis/custom_widgets/custom_text_field.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.adaptive.arrow_back, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                70.h,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'OTP Verfication',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                5.h,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Enter your 6 digit OTP',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                35.h,
                Align(
                  alignment: Alignment.center,

                  child: Image.asset(AppImages.strongPassword),
                ),
                20.h,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Pinput(
                      length: 6,
                      showCursor: true,
                      obscureText: true,
                      obscuringCharacter: '*',
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      submittedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      onCompleted: (pin) {
                      },
                    ),
                  ),
                ),
                22.h,
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Resend OTP",style: TextStyle(color: AppColors.primary,fontSize: 16,fontWeight: FontWeight.w400),),
                    )),
                20.h,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    backgroundColor: AppColors.primary,
                    text: "VERIFY",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      Get.toNamed(AppRoutes.resetPassword);
                    },
                  ),
                ),
                20.h
              ],
            ),
          ),
        ),
      ),
    );
  }

}
