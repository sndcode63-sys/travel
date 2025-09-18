import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxService {
  static StorageServices get to => Get.find();
  late GetStorage _box;

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
    _box = GetStorage();
  }

  // -------------------------
  // UniqueKey Management
  // -------------------------
  String? getUniqueKey() => _box.read('uniqueKey');
  void setUniqueKey(String key) => _box.write('uniqueKey', key);
  void removeUniqueKey() => _box.remove('uniqueKey');

  // -------------------------
  // Authorization Token Management
  // -------------------------
  String? getAuthorizationToken() => _box.read('authorization_token');
  void setAuthorizationToken(String token) => _box.write('authorization_token', token);
  void removeAuthorizationToken() => _box.remove('authorization_token');

  // -------------------------
  // Language Management
  // -------------------------
  String? getLanguage() => _box.read('language');
  void setLanguage(String language) => _box.write('language', language);

  // -------------------------
  // Theme Management
  // -------------------------
  bool isDarkMode() => _box.read('darkMode') ?? false;
  void setDarkMode(bool value) => _box.write('darkMode', value);

  // -------------------------
  // Generic Storage methods
  // -------------------------
  T? read<T>(String key) => _box.read(key);
  void write<T>(String key, T value) => _box.write(key, value);
  void remove(String key) => _box.remove(key);
  void clear() => _box.erase();
}



