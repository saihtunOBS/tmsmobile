import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/auth_bloc.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';
import '../utils/strings.dart';

class CheckPasswordView extends StatelessWidget {
  const CheckPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthBloc>(
      builder: (BuildContext context, bloc, Widget? child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kMargin24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: kMarginMedium,
            children: [
              Text(
                kYourPasswordMustContainLabel.toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular2x),
              ),
              Row(
                spacing: kMarginMedium,
                children: [
                  Container(
                    width: kMarginMedium14,
                    height: kMarginMedium14,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: bloc.isMore8character == true ? 3.0 : 0.0,
                            color: bloc.isMore8character == true
                                ? kSecondaryColor
                                : kWhiteColor)),
                    child: Image.asset(
                      kRadioImage,
                    ),
                  ),
                  Text(kCharacterLabel)
                ],
              ),
              Row(
                spacing: kMarginMedium,
                children: [
                  Container(
                    width: kMarginMedium14,
                    height: kMarginMedium14,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: bloc.isUpperCaseContain == true ? 3.0 : 0.0,
                            color: bloc.isUpperCaseContain == true
                                ? kSecondaryColor
                                : kWhiteColor)),
                    child: Image.asset(
                      kRadioImage,
                    ),
                  ),
                  Text(kUppercaseLetterLabel)
                ],
              ),
              Row(
                spacing: kMarginMedium,
                children: [
                  Container(
                    width: kMarginMedium14,
                    height: kMarginMedium14,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: bloc.isNumberContain == true ? 3.0 : 0.0,
                            color: bloc.isNumberContain == true
                                ? kSecondaryColor
                                : kWhiteColor)),
                    child: Image.asset(
                      kRadioImage,
                    ),
                  ),
                  Text(kOneOrMoreNumberLabel)
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Container(
                    width: kMarginMedium14,
                    height: kMarginMedium14,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width:
                                bloc.isSpecialNumberContain == true ? 3.0 : 0.0,
                            color: bloc.isSpecialNumberContain == true
                                ? kSecondaryColor
                                : kWhiteColor)),
                    child: Image.asset(
                      kRadioImage,
                    ),
                  ),
                  Text(kOneOrMoreSpecialCharacterLabel)
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
