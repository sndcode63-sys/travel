import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/auth/reset_password/reset_pass_repo.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';

class ResetPassowrdController extends GetxController {
  RxBool obscureNew = true.obs;
  RxBool obscureConfirm = true.obs;

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  RxBool isButtonEnabled = false.obs;
  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;

  void toggleNew() => obscureNew.value = !obscureNew.value;
  void toggleConfirm() => obscureConfirm.value = !obscureConfirm.value;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      emailController.text = Get.arguments['email'] ?? "";
      otpController.text = Get.arguments['otp'] ?? "";
    }

    newPasswordController.addListener(_validateFields);
    confirmPasswordController.addListener(_validateFields);
  }

  void _validateFields() {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      errorMessage.value = "";
      isButtonEnabled.value = false;
      return;
    }

    if (newPass.length < 8) {
      errorMessage.value = "Password must be at least 8 characters long";
      isButtonEnabled.value = false;
      return;
    }
    // if (!RegExp(r'[A-Z]').hasMatch(newPass)) {
    //   errorMessage.value = "Password must contain at least 1 uppercase letter";
    //   isButtonEnabled.value = false;
    //   return;
    // }
    // if (!RegExp(r'[a-z]').hasMatch(newPass)) {
    //   errorMessage.value = "Password must contain at least 1 lowercase letter";
    //   isButtonEnabled.value = false;
    //   return;
    // }
    // if (!RegExp(r'[0-9]').hasMatch(newPass)) {
    //   errorMessage.value = "Password must contain at least 1 number";
    //   isButtonEnabled.value = false;
    //   return;
    // }
    // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPass)) {
    //   errorMessage.value = "Password must contain at least 1 special character";
    //   isButtonEnabled.value = false;
    //   return;
    // }
    if (newPass != confirmPass) {
      errorMessage.value = "Passwords do not match";
      isButtonEnabled.value = false;
      return;
    }

    errorMessage.value = "";
    isButtonEnabled.value = true;
  }

  Future<void> onSubmit() async {

    if (!isButtonEnabled.value) return;

    isLoading.value = true;
    try {
      final result = await ResetPassRepo.resetPass(
        email: emailController.text.trim(),
        otp: otpController.text.trim(),
        password: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      if (result.status == 200) {
        print("----------");
        print("----------");
        print("----------");
        print(result.message);
        print("----------");
        print("----------");
        print("----------");
        print("----------");

        CustomNotifier.showSnackbar(message: result.message.toString());

        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.snackbar(
          "Error",
          result.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.orangeAccent,
        );
        CustomNotifier.showSnackbar(message: result.message.toString(),isSuccess: false);

      }
    }
    finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
