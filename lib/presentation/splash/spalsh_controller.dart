import 'package:get/get.dart';
import '../../data/services/api_manager.dart';
import '../../utlis/app_routes.dart';
import 'splash_repository.dart';



class SplashController extends GetxController {
  RxDouble scale = 0.0.obs;
  RxDouble opacity = 0.0.obs;

  final UserRepository _userRepository = UserRepository();

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
    _navigateUser();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    scale.value = 1.0;
    await Future.delayed(const Duration(milliseconds: 500));
    opacity.value = 1.0;
  }

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = AuthService.to.storage.read('authorization_token');

    if (token != null && token.isNotEmpty) {
      try {
        final userData = await _userRepository.getUserDetails();

        // AuthService me save kar do
        AuthService.to.saveUser(userData);

        Get.offAllNamed(AppRoutes.dashBoard, arguments: userData);
      } catch (e) {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
