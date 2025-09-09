import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassowrdController extends GetxController {
  // Observable variables for toggling password
  RxBool obscureNew = true.obs;
  RxBool obscureConfirm = true.obs;

  // Text controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Button enable/disable
  RxBool isButtonEnabled = false.obs;

  // Error message
  RxString errorMessage = "".obs;

  void toggleNew() => obscureNew.value = !obscureNew.value;
  void toggleConfirm() => obscureConfirm.value = !obscureConfirm.value;

  @override
  void onInit() {
    super.onInit();
    newPasswordController.addListener(_validateFields);
    confirmPasswordController.addListener(_validateFields);
  }

  void _validateFields() {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    // Empty check
    if (newPass.isEmpty || confirmPass.isEmpty) {
      errorMessage.value = "";
      isButtonEnabled.value = false;
      return;
    }

    // Length check
    if (newPass.length < 8) {
      errorMessage.value = "Password must be at least 8 characters long";
      isButtonEnabled.value = false;
      return;
    }

    // Uppercase check
    if (!RegExp(r'[A-Z]').hasMatch(newPass)) {
      errorMessage.value = "Password must contain at least 1 uppercase letter";
      isButtonEnabled.value = false;
      return;
    }

    // Lowercase check
    if (!RegExp(r'[a-z]').hasMatch(newPass)) {
      errorMessage.value = "Password must contain at least 1 lowercase letter";
      isButtonEnabled.value = false;
      return;
    }

    // Number check
    if (!RegExp(r'[0-9]').hasMatch(newPass)) {
      errorMessage.value = "Password must contain at least 1 number";
      isButtonEnabled.value = false;
      return;
    }

    // Special character check
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPass)) {
      errorMessage.value = "Password must contain at least 1 special character";
      isButtonEnabled.value = false;
      return;
    }

    // Confirm password check
    if (newPass != confirmPass) {
      errorMessage.value = "Passwords do not match";
      isButtonEnabled.value = false;
      return;
    }

    // ✅ All validations passed
    errorMessage.value = "";
    isButtonEnabled.value = true;
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
