// ignore_for_file: use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/announcement_bloc.dart';
import 'package:tmsmobile/pages/home/announcement_page.dart';
import 'package:tmsmobile/utils/route_observer.dart';
import '../main.dart';
import 'local_notification_service.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class NotificationService {
  final BuildContext context;

  NotificationService(this.context);
//permission
  requestPermission() async {
    await _firebaseMessaging.requestPermission(
        sound: true, alert: true, badge: true, provisional: false);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    listenIncomingMessage();
  }

  listenIncomingMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var complainBloc = Provider.of<AnnouncementBloc>(
          navigatorKey.currentContext!,
          listen: false);
      complainBloc.getAnnouncement();
      LocalNotificationService().displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle navigation after a user taps on the notification
      if (CurrentRouteObserver.currentRoute != 'AnnouncementPage') {
        navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => AnnouncementPage(),
            settings: RouteSettings(name: "AnnouncementPage"),
          ),
        );
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      await Firebase.initializeApp();

      if (message == null) return;

      navigatorKey.currentState?.pushNamed(
        '/',
      );

      Future.delayed((Duration(seconds: 3)), () {
        if (CurrentRouteObserver.currentRoute != 'AnnouncementPage') {
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => AnnouncementPage(),
              settings: RouteSettings(name: "AnnouncementPage"),
            ),
          );
        }
      });
     
    });
  }

  Future<void> getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('token is....$token');
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
