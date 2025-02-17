import 'package:flutter/material.dart';

class CurrentRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  static String? currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      currentRoute = route.settings.name;
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute) {
      currentRoute = previousRoute.settings.name;
    } else {
      currentRoute = null;
    }
  }
}
