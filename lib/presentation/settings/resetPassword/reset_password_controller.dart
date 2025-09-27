import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'change_repository.dart';

class ResetPasswordController extends GetxController {
  RxBool obscureNew = true.obs;
  RxBool obscureConfirm = true.obs;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  RxBool isButtonEnabled = false.obs;
  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;

  void toggleNew() => obscureNew.value = !obscureNew.value;
  void toggleConfirm() => obscureConfirm.value = !obscureConfirm.value;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {

    }

    newPasswordController.addListener(_validateFields);
    confirmPasswordController.addListener(_validateFields);
    oldPasswordController.addListener(_validateFields);
  }

  void _validateFields() {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();
    final oldPass = oldPasswordController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      errorMessage.value = "";
      isButtonEnabled.value = false;
      return;
    }

    if (newPass.length < 6) {
      errorMessage.value = "Password must be at least 6 characters long";
      isButtonEnabled.value = false;
      return;
    }

    if (newPass != confirmPass) {
      errorMessage.value = "Passwords do not match";
      isButtonEnabled.value = false;
      return;
    }
    if (oldPass == newPass) {
      errorMessage.value = "New password cannot be same as old password";
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
      final result = await ChangeRepository.changePass(
        oldPassword: oldPasswordController.text.trim(),
        password: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
      if (result.status == 200) {


        CustomNotifier.showSnackbar(message: result.message.toString());

        Get.offAllNamed(AppRoutes.dashBoard);
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
    oldPasswordController.dispose();
    super.onClose();
  }
}
