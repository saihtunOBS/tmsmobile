// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmsmobile/bloc/announcement_bloc.dart';
// import 'package:tmsmobile/pages/auth/splash_screen_page.dart';
// import 'package:tmsmobile/pages/home/announcement_page.dart';
// import 'package:tmsmobile/utils/route_observer.dart';
import '../bloc/epc_bloc.dart';
import '../main.dart';
import 'local_notification_service.dart';

StreamController epcStreamController = BehaviorSubject.seeded(false);

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
      var currentContext = navigatorKey.currentContext;
      if (currentContext != null) {
        Future.microtask(()  {
          var epcBloc = Provider.of<EpcBloc>(currentContext, listen: false);
          var announcementBloc =
              Provider.of<AnnouncementBloc>(currentContext, listen: false);

          epcBloc.getEpc();
          announcementBloc.getAnnouncement();

          // Force UI rebuild if HomePage is mounted
          if (currentContext.mounted) {
            (currentContext as Element).markNeedsBuild();
          }
        });
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

      if (message == null) return;

      // navigatorKey.currentState!.push(
      //   MaterialPageRoute(
      //     builder: (_) => SplashScreenPage(),
      //   ),
      // );

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
