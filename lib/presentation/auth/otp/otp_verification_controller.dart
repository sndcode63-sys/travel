import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'otp_repository.dart';

class OtpVerificationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final emailController = TextEditingController();

  var isLoading = false.obs;
  var secondsRemaining = 0.obs;
  Timer? _timer;

  RxString otpMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      emailController.text = args["email"] ?? "";
      otpMessage.value = args["message"] ?? "";
    }
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    emailController.dispose();
    super.onClose();
  }

  // OTP Validation
  String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) return "OTP is required";
    if (value.length != 6) return "OTP must be 6 digits";
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) return "OTP must contain only numbers";
    return null;
  }

  // Timer text in MM:SS format
  String get timerText {
    final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  // Verify OTP
  Future<void> onVerify() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final result = await OtpRepository.submitOtp(
        email: emailController.text.trim(),
        code: otpController.text.trim(),
      );

      if(result.status==200){
        CustomNotifier.showSnackbar(
          message: result.message ?? "OTP Verified Successfully",
        );
        Get.toNamed(
          AppRoutes.resetPassword,
          arguments: {
            "email": emailController.text.trim(),
            "otp": otpController.text.trim(),
          },
        );

      }else{
        CustomNotifier.showSnackbar(
          message: result.message ?? "OTP Verified Successfully",
          isSuccess: false
        );

      }


    } catch (e) {
      CustomNotifier.showSnackbar(
        message: e.toString(),
        isSuccess: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Resend OTP
  Future<void> onResendOtp() async {
    if (secondsRemaining.value > 0) return; // wait until timer ends

    try {
      isLoading.value = true;
      final result = await OtpRepository.resendOtp(
        email: emailController.text.trim(),
      );

      otpMessage.value = result.message ?? "OTP sent successfully";

      CustomNotifier.showSnackbar(
        message: result.message ?? "OTP sent successfully",
      );

      _startTimer(); // restart countdown
    } catch (e) {
      CustomNotifier.showSnackbar(
        message: e.toString(),
        isSuccess: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Start countdown timer (default 5 minutes)
  void _startTimer({int durationInSeconds = 300}) {
    secondsRemaining.value = durationInSeconds;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }
}


