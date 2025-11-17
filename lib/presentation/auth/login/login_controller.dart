import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import '../../../data/services/api_manager.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../splash/splash_repository.dart';
import 'login_repository.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observables
  RxBool obscurePassword = true.obs;
  RxBool isButtonEnabled = false.obs;

  // Toggle password visibility
  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }
  // On Sign In
  void onSignIn() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final loginData = await LoginRepository.login(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (loginData.status == 200) {
        CustomNotifier.showSnackbar(
          message: loginData.message.toString(),
        );

        //  Fetch full user details after login
        final userRepository = UserRepository();
        final userData = await userRepository.getUserDetails();

        //  Save to AuthService
        await AuthService.to.saveUser(userData);

        //  Navigate with user data
        Get.offNamed(AppRoutes.dashBoard, arguments: userData);
      } else {
        CustomNotifier.showSnackbar(
          message: loginData.message.toString(),
          isSuccess: false,
        );
      }
    } catch (e) {
      CustomNotifier.showSnackbar(
        message: e.toString(),
        isSuccess: false,
      );
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
