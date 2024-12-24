import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

Widget gradientButton({String? title,required VoidCallback? onPress}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: kMargin24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMarginMedium),
        gradient: LinearGradient(
          colors: [kPrimaryColor, kThirdColor],
          stops: [0.0, 1.0],
        ),
      ),
      child: Center(
        child: Text(
          title ?? kContinueLabel,
          style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: kTextRegular18),
        ),
      ),
    ),
  );
}
