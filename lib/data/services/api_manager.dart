import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/User/user_models.dart';


class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final GetStorage storage = GetStorage();

  Rx<UserModels?> userData = Rx<UserModels?>(null);

  // Extra reactive variable for instant profile pic update
  RxString profileImageBase64 = "".obs;

  Future<AuthService> init() async {
    await _loadUserFromStorage();
    return this;
  }

  Future<void> _loadUserFromStorage() async {
    final userJson = storage.read('user_data');
    if (userJson != null && userJson is Map<String, dynamic>) {
      userData.value = UserModels.fromJson(userJson);
      profileImageBase64.value = userData.value?.profilePic ?? "";
    }
  }

  void saveUser(UserModels user) {
    userData.value = user;
    storage.write('user_data', user.toJson());
    profileImageBase64.value = user.profilePic ?? "";
  }

  void updateProfilePic(String profilePic) {
    if (userData.value != null) {
      // Update user model
      userData.update((user) {
        if (user != null) user.profilePic = profilePic;
      });

      // Update storage
      storage.write('user_data', userData.value!.toJson());

      // ✅ Update reactive variable for instant UI rebuild
      profileImageBase64.value = profilePic;
    }
  }

  void clearUser() {
    userData.value = null;
    storage.remove('user_data');
    profileImageBase64.value = "";
  }
}
