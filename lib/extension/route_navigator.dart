import 'package:flutter/material.dart';

class PageNavigator {
  BuildContext? ctx;
  PageNavigator({required this.ctx});

  //navigate to next page
  Future nextPage({required Widget? page, bool withNav = false}) {
    return Navigator.push(
        ctx!, MaterialPageRoute(builder: ((context) => page!)));
  }

  Future nextPageOnly({Widget? page}) {
    return Navigator.pushAndRemoveUntil(ctx!,
        MaterialPageRoute(builder: ((context) => page!)), (route) => false);
  }

  Route popUp(Widget? page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page!,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.fastOutSlowIn;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}

Route createRoute(Widget page, {int? duration}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: duration ?? 900),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
