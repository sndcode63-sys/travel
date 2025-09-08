// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationHelper {
//   NotificationHelper._();
//   static final instance = NotificationHelper._();
//
//   final FlutterLocalNotificationsPlugin _localNotifications =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> initLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = IOSInitializationSettings();
//     const initSettings =
//     InitializationSettings(android: androidSettings, iOS: iosSettings);
//     await _localNotifications.initialize(initSettings);
//   }
//
//   Future<void> showLocalNotification({
//     required String title,
//     required String body,
//     int id = 0,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'default_channel', 'Default Channel',
//       channelDescription: 'General notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const iosDetails = IOSNotificationDetails();
//     const platformDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
//
//     await _localNotifications.show(id, title, body, platformDetails);
//   }
//
//   Future<void> initPushNotifications() async {
//     await FirebaseMessaging.instance.requestPermission();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showLocalNotification(
//         title: message.notification?.title ?? '',
//         body: message.notification?.body ?? '',
//       );
//     });
//   }
// }
