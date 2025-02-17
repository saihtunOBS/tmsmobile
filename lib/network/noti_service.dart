import 'dart:io';
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
            iOS: iosSettings);

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {},
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> displayNotification(dynamic title, dynamic body) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'my_app_channel', 'my_app_channel',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
        showBadge: true,
        enableVibration: true,
        playSound: true);

    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: 'default',
            interruptionLevel: InterruptionLevel.timeSensitive,
            categoryIdentifier: 'cat_1',
            badgeNumber: 0,
          ),
          android: AndroidNotificationDetails(
            icon: "@drawable/noti_icon",
            color: kPrimaryColor,
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            visibility: NotificationVisibility.public,
            actions: [
              // const AndroidNotificationAction('View', 'View', showsUserInterface: true),
            ],
          ),
        ),
      );
    } catch (e) {
      print("Error displaying notification: $e");
    }
  }
}
