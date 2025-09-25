import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'forget_password_repository.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // text editor controller
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;


  // On Verify OTP
  void verifyOtp() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final response = await ForgetPasswordRepository.requestOtp(
        email: emailController.text.trim(),
      );

      if (response.status == 200) {
        CustomNotifier.showSnackbar(message: "OTP sent successfully!");

        Get.toNamed(
          AppRoutes.otpVerification,
          arguments: emailController.text.trim(),
        );
      } else {
        CustomNotifier.showSnackbar(message: "Something went wrong!", isSuccess: false);

      }
    } catch (e) {
      CustomNotifier.showSnackbar(message: "Otp invalid!", isSuccess: false);

    }
  }
}
