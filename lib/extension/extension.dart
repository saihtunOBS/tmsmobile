import 'package:flutter/cupertino.dart';

class PageNavigator {
  BuildContext? ctx;
  PageNavigator({required this.ctx});

  //navigate to next page
  Future nextPage({Widget? page, bool withNav = false}) {
    return Navigator.push(
        ctx!, CupertinoPageRoute(builder: ((context) => page!)));
  }

  Future nextPageOnly({Widget? page}) {
    return Navigator.pushAndRemoveUntil(ctx!,
        CupertinoPageRoute(builder: ((context) => page!)), (route) => false);
  }

}