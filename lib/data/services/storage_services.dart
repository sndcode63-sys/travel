import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../utlis/app_routes.dart';
import '../../models/User/user_models.dart';

class StorageServices extends GetxService {
  static StorageServices get to => Get.find();
  late GetStorage _box;

  @override
  Future<void> onInit() async {
    await GetStorage.init();
    _box = GetStorage();
    super.onInit();
  }

  // -------------------------
  // Token Management
  // -------------------------
  String? getAuthorizationToken() => _box.read('authorization_token');
  void setAuthorizationToken(String token) => _box.write('authorization_token', token);
  void removeAuthorizationToken() => _box.remove('authorization_token');

  // -------------------------
  // Unique Key
  // -------------------------
  String? getUniqueKey() => _box.read('uniqueKey');
  void setUniqueKey(String key) => _box.write('uniqueKey', key);
  void removeUniqueKey() => _box.remove('uniqueKey');

  // -------------------------
  // Language
  // -------------------------
  String? getLanguage() => _box.read('language');
  void setLanguage(String language) => _box.write('language', language);

  // -------------------------
  // Theme
  // -------------------------
  bool isDarkMode() => _box.read('darkMode') ?? false;
  void setDarkMode(bool value) => _box.write('darkMode', value);

  // -------------------------
  // User Management
  // -------------------------
  void setUser(UserModels user) => write('user_data', user.toJson());

  UserModels? getUser() {
    final json = read('user_data');
    if (json != null && json is Map<String, dynamic>) {
      return UserModels.fromJson(json);
    }
    return null;
  }

  // -------------------------
  // Generic Methods
  // -------------------------
  T? read<T>(String key) => _box.read(key);
  void write<T>(String key, T value) => _box.write(key, value);
  void remove(String key) => _box.remove(key);
  void clear() => _box.erase();

  // -------------------------
  // Logout
  // -------------------------
  void logout() {
    removeAuthorizationToken();
    removeUniqueKey();
    clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
