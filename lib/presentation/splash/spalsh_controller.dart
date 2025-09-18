import 'package:get/get.dart';

import '../../data/services/storage_services.dart';
import '../../utlis/app_routes.dart';

class SplashController extends GetxController {
  // Rx variables for animation
  RxDouble scale = 0.0.obs;
  RxDouble opacity = 0.0.obs;

  // Storage instance
  final storage = StorageServices.to;

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
    _navigateUser();
  }

  /// 🔹 Start animations
  void _startAnimation() async {
    // Scale-in
    await Future.delayed(const Duration(milliseconds: 300));
    scale.value = 1.0;

    // Fade-in text
    await Future.delayed(const Duration(milliseconds: 500));
    opacity.value = 1.0;
  }

  /// 🔹 Navigate after splash
  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = storage.getUniqueKey();

    if (token != null && token.isNotEmpty) {
      // User login hai → Dashboard
      Get.offAllNamed(AppRoutes.dashBoard);
    } else {
      // User login nahi hai → Login screen
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
