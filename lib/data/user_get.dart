import 'services/storage_services.dart';
import '../../models/User/user_models.dart';

import 'dart:convert';


class UserStorage {
  static const _key = 'user_data';

  static void saveUser(UserModels user) {
    final jsonString = jsonEncode(user.toJson());
    StorageServices.to.write(_key, jsonString);
  }

  static UserModels? getUser() {
    final jsonString = StorageServices.to.read<String>(_key);
    if (jsonString != null && jsonString.isNotEmpty) {
      return UserModels.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  static void removeUser() {
    StorageServices.to.remove(_key);
  }
}

