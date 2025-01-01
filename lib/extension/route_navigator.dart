import 'package:flutter/cupertino.dart';

class PageNavigator {
  BuildContext? ctx;
  PageNavigator({required this.ctx});

  //navigate to next page
  Future nextPage({required Widget? page, bool withNav = false}) {
    return Navigator.push(
        ctx!, CupertinoPageRoute(builder: ((context) => page!)));
  }

  Future nextPageOnly({Widget? page}) {
    return Navigator.pushAndRemoveUntil(ctx!,
        CupertinoPageRoute(builder: ((context) => page!)), (route) => false);
  }

}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 900),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

