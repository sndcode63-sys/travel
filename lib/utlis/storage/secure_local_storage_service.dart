import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SecureLocalStorageService {
  static final SecureLocalStorageService _instance =
  SecureLocalStorageService._internal();
  factory SecureLocalStorageService() => _instance;
  SecureLocalStorageService._internal();

  final _secure = const FlutterSecureStorage();
  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    final encryptionKey = await _getEncryptionKey();
    _box = await Hive.openBox(
      'secureAppBox',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  Future<List<int>> _getEncryptionKey() async {
    final keyStr = await _secure.read(key: 'hive_key_b64');
    if (keyStr != null) return base64Decode(keyStr);
    final newKey = Hive.generateSecureKey();
    await _secure.write(key: 'hive_key_b64', value: base64Encode(newKey));
    return newKey;
  }

  Future<void> write(String key, dynamic value) async => _box.put(key, value);
  dynamic read(String key) => _box.get(key);
  Future<void> delete(String key) async => _box.delete(key);
  Future<void> clear() async => _box.clear();
  bool contains(String key) => _box.containsKey(key);

  Future<void> writeSecure(String key, String value) async =>
      _secure.write(key: key, value: value);
  Future<String?> readSecure(String key) async => _secure.read(key: key);
  Future<void> deleteSecure(String key) async => _secure.delete(key: key);
  Future<void> clearSecure() async => _secure.deleteAll();
}
