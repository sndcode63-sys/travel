import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  /// Request single permission
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// Check if permission is already granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  /// Request multiple permissions at once
  static Future<Map<Permission, PermissionStatus>> requestMultiple(
      List<Permission> permissions) async {
    return await permissions.request();
  }

  /// Open app settings (if user denied permanently)
  static Future<bool> openAppSettingsPage() async {
    return await openAppSettings();
  }
}
