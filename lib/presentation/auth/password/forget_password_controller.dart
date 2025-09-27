import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'forget_password_repository.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // text editing controller
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> verifyOtp() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final loginData = await ForgetPasswordRepository.requestOtp(
      email: emailController.text.trim(),
      selectType: '',
      type: '',
    );
    print(loginData.status);
    print(loginData.message);

    final msg = loginData.message ?? "Something went wrong";
    CustomNotifier.showSnackbar(
      message: msg,
      isSuccess: loginData.status == 200,
    );

    if (loginData.status == 200) {
      Get.toNamed(AppRoutes.otpVerification,
          arguments: emailController.text.trim());
    }

    isLoading.value = false;
  }
}

