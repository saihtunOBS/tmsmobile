import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import '../utils/colors.dart';

Future showConnectionError(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: kBlackColor,
        elevation: 6.0,
        hitTestBehavior: HitTestBehavior.deferToChild,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        content: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            CupertinoIcons.wifi_slash,
            color: kWhiteColor,
          ),
          10.hGap,
          Text(
            'You are currently offline.',
            style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w600),
          ),
        ])),
  );
}
