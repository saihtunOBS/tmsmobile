import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

Widget gradientButton(
    {String? title, required VoidCallback? onPress, bool? isLogout}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 55,
      margin: EdgeInsets.only(
          left: kMarginMedium2, right: kMarginMedium2, bottom: kMargin5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMarginMedium),
        gradient: LinearGradient(
          colors: [kPrimaryColor, kThirdColor],
          stops: [0.0, 1.0],
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLogout == true
                ? Icon(
                    CupertinoIcons.square_arrow_right,
                    color: kWhiteColor,
                  )
                : SizedBox(),
            isLogout == true ? 5.hGap : 0.hGap,
            Text(
              title ?? kContinueLabel,
              style: TextStyle(
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: kTextRegular18),
            ),
          ],
        ),
      ),
    ),
  );
}
