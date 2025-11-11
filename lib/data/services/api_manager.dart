import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/User/user_models.dart';

/// AuthService handles user authentication and session management using GetStorage.
class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();

  final GetStorage storage = GetStorage();

  /// Reactive user data
  Rx<UserModels?> userData = Rx<UserModels?>(null);
  RxString profileImageBase64 = "".obs;

  /// Getter for current user
  UserModels? get user => userData.value;

  /// Check if user is logged in
  bool get isLoggedIn => userData.value != null;

  /// Profile image getter (fallback safe)
  String get profilePic =>
      profileImageBase64.value.isNotEmpty
          ? profileImageBase64.value
          : (userData.value?.profilePic ?? "");

  /// Initialize AuthService and load user from local storage
  Future<AuthService> init() async {
    await _loadUserFromStorage();
    return this;
  }

  /// Load user data from GetStorage
  Future<void> _loadUserFromStorage() async {
    try {
      final userJson = storage.read('user_data');

      if (userJson != null && userJson.toString().isNotEmpty) {
        final decoded = userJson is String ? jsonDecode(userJson) : userJson;
        userData.value = UserModels.fromJson(decoded);
        profileImageBase64.value = userData.value?.profilePic ?? '';
      }
    } catch (e) {
      print("⚠️ Error loading user from GetStorage: $e");
    }
  }

  /// Save user data to GetStorage
  Future<void> saveUser(UserModels user) async {
    try {
      userData.value = user;
      profileImageBase64.value = user.profilePic ?? '';

      await storage.write('user_data', user.toJson());
      print("✅ User saved successfully: ${user.name}");
    } catch (e) {
      print("⚠️ Error saving user: $e");
    }
  }

  /// Update user profile picture
  Future<void> updateProfilePic(String profilePic) async {
    if (userData.value == null) return;

    userData.update((u) {
      if (u != null) u.profilePic = profilePic;
    });
    profileImageBase64.value = profilePic;

    await storage.write('user_data', userData.value!.toJson());
    print("🖼️ Profile picture updated.");
  }

  /// Update any field in user model
  Future<void> updateUserField(String key, dynamic value) async {
    if (userData.value == null) return;

    final updated = userData.value!.toJson();
    updated[key] = value;

    final newUser = UserModels.fromJson(updated);
    await saveUser(newUser);

    print("✅ User field '$key' updated.");
  }

  /// Clear user data (logout)
  Future<void> clearUser() async {
    userData.value = null;
    profileImageBase64.value = "";
    await storage.remove('user_data');
    print("🚪 User logged out and data cleared.");
  }
}
