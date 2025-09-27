import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'forget_password_repository.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> verifyOtp() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final result = await ForgetPasswordRepository.requestOtp(
        email: emailController.text.trim(),
        selectType: '',
        type: 'Forgot Password',
      );

      final msg = result.message ?? "OTP sent successfully";

      CustomNotifier.showSnackbar(
        message: msg,
        isSuccess: true,
      );

      Get.toNamed(
        AppRoutes.otpVerification,
        arguments: {
          "email": emailController.text.trim(),
          "message": msg,
        },
      );
    } catch (e) {
      CustomNotifier.showSnackbar(
        message: e.toString(),
        isSuccess: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

