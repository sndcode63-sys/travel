import 'dart:io';

// class DeviceInfoHelper {
//   static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
//
//   // Get device model (Android/iOS)
//   static Future<String> getDeviceModel() async {
//     if (Platform.isAndroid) {
//       final androidInfo = await _deviceInfo.androidInfo;
//       return "${androidInfo.manufacturer} ${androidInfo.model}";
//     } else if (Platform.isIOS) {
//       final iosInfo = await _deviceInfo.iosInfo;
//       return iosInfo.utsname.machine ?? "iOS Device";
//     }
//     return "Unknown Device";
//   }
//
//   // Get OS version
//   static Future<String> getOSVersion() async {
//     if (Platform.isAndroid) {
//       final androidInfo = await _deviceInfo.androidInfo;
//       return "Android ${androidInfo.version.release}";
//     } else if (Platform.isIOS) {
//       final iosInfo = await _deviceInfo.iosInfo;
//       return "${iosInfo.systemName} ${iosInfo.systemVersion}";
//     }
//     return "Unknown OS";
//   }
//
//   // Unique Device Identifier
//   static Future<String> getDeviceId() async {
//     if (Platform.isAndroid) {
//       final androidInfo = await _deviceInfo.androidInfo;
//       return androidInfo.id;
//     } else if (Platform.isIOS) {
//       final iosInfo = await _deviceInfo.iosInfo;
//       return iosInfo.identifierForVendor ?? "Unknown ID";
//     }
//     return "Unknown ID";
//   }
// }
