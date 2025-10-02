import 'package:get/get.dart';

import '../../data/services/storage_services.dart';
import '../../models/User/user_models.dart';
import '../../utlis/app_routes.dart';

import 'package:get/get.dart';
import '../../data/services/storage_services.dart';
import '../../utlis/app_routes.dart';
import 'splash_repository.dart';

class SplashController extends GetxController {
  // Rx variables for animation
  RxDouble scale = 0.0.obs;
  RxDouble opacity = 0.0.obs;

  // Storage instance
  final storage = StorageServices.to;
  final UserRepository _userRepository = UserRepository();

  Rx<UserModels?> user = Rx<UserModels?>(null);

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
    _navigateUser();
  }

  /// 🔹 Start animations
  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    scale.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 500));
    opacity.value = 1.0;
  }

  /// 🔹 Navigate after splash
  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = storage.getAuthorizationToken();

    if (token != null && token.isNotEmpty) {
      try {
        // 🔹 API call → user details fetch karo
        final userData = await _userRepository.getUserDetails();
        user.value = userData;

        // User details mil gaya → Dashboard
        Get.offAllNamed(AppRoutes.dashBoard, arguments: userData);
      } catch (e) {
        // Agar API fail ho gayi → Login screen
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      // Token hi nahi hai → Login screen
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
