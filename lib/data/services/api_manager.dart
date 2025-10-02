import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/User/user_models.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final GetStorage storage = GetStorage();

  Rx<UserModels> userData = UserModels().obs;

  Future<AuthService> init() async {
    await GetStorage.init();
    _loadUserFromStorage();
    return this;
  }

  void _loadUserFromStorage() {
    final userJson = storage.read('user_data');
    if (userJson != null) {
      userData.value = UserModels.fromJson(Map<String, dynamic>.from(userJson));
    }
  }

  void saveUser(UserModels user) {
    userData.value = user;
    storage.write('user_data', user.toJson());
  }
}
