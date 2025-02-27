// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmsmobile/bloc/announcement_bloc.dart';
import 'package:tmsmobile/bloc/notification_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
// import 'package:tmsmobile/pages/auth/splash_screen_page.dart';
// import 'package:tmsmobile/pages/home/announcement_page.dart';
// import 'package:tmsmobile/utils/route_observer.dart';
import '../main.dart';
import '../pages/home/announcement_page.dart';
import '../utils/route_observer.dart';
import 'local_notification_service.dart';

StreamController epcStreamController = BehaviorSubject.seeded('');

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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      LocalNotificationService().displayNotification(message);

      final RemoteNotification? notification = message.notification;
      epcStreamController.sink.add(notification?.body ?? '');
      var currentContext = navigatorKey.currentContext;
      if (currentContext != null) {
        var announcementBloc =
            Provider.of<AnnouncementBloc>(currentContext, listen: false);
        var notiBloc =
            Provider.of<NotificationBloc>(currentContext, listen: false);

        announcementBloc.getAnnouncement();
        notiBloc.getNotification();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle navigation after a user taps on the notification
      // if (CurrentRouteObserver.currentRoute != 'AnnouncementPage') {
      //   navigatorKey.currentState!.push(
      //     MaterialPageRoute(
      //       builder: (_) => AnnouncementPage(),
      //       settings: RouteSettings(name: "AnnouncementPage"),
      //     ),
      //   );
      // }
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      await Firebase.initializeApp();

      if (message == null || PersistenceData.shared.getToken() == null) return;

      // Future.delayed((Duration(seconds: 3)), () {
      //   if (CurrentRouteObserver.currentRoute != 'AnnouncementPage') {
      //     navigatorKey.currentState!.push(
      //       MaterialPageRoute(
      //         builder: (_) => AnnouncementPage(),
      //         settings: RouteSettings(name: "AnnouncementPage"),
      //       ),
      //     );
      //   }
      // });
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
