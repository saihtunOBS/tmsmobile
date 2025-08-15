import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../utils/colors.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@drawable/noti_icon'),
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse:
      //     (NotificationResponse notificationResponse) async {
      //   if (notificationResponse.payload == null) {
      //     print('payload is null');
      //   } else {
      //     if (CurrentRouteObserver.currentRoute != 'AnnouncementPage') {
      //       navigatorKey.currentState!.push(
      //         MaterialPageRoute(
      //           builder: (_) => AnnouncementPage(),
      //           settings: RouteSettings(name: "AnnouncementPage"),
      //         ),
      //       );
      //     }
      //   }
      // },
      // onDidReceiveBackgroundNotificationResponse: (details) {
      //   if (details.payload == null) {
      //     print('payload is null');
      //   } else {
      //     if (CurrentRouteObserver.currentRoute != 'AnnouncementPage') {
      //       navigatorKey.currentState!.push(
      //         MaterialPageRoute(
      //           builder: (_) => AnnouncementPage(),
      //           settings: RouteSettings(name: "AnnouncementPage"),
      //         ),
      //       );
      //     }
      //   }
      // },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> displayNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_app_channel',
      'my_app_channel',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      showBadge: true,
      enableVibration: true,
      playSound: true,
    );
    Future.delayed(Duration(milliseconds: 100), () async {
      try {
        if (message.notification != null) {
          // IMPORTANT: Create channel for Android
          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(channel);

          await flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification?.title ?? '',
            message.notification?.body ?? '',
            NotificationDetails(
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                priority: Priority.high,
                icon: "@drawable/noti_icon",
                color: kPrimaryColor,
              ),
            ),
          );
        }
      } catch (e) {
        debugPrint("Notification error: $e");
      }
    });
  }
}
