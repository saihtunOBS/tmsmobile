import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../utils/images.dart';

class AccountTermAndConditionPage extends StatelessWidget {
  const AccountTermAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              kBillingBackgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(top: 0, child: ProfileAppbar()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: kMargin6,
              children: [
                SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                Text(
                  kAgreementLabel.toUpperCase(),
                  style: TextStyle(
                    fontSize: AppData.shared.getSmallFontSize(),
                  ),
                ),
                Text(
                  kTremOfServiceLabel,
                  style: TextStyle(
                          fontFamily: AppData.shared.fontFamily2,
                      fontSize: kTextRegular32 - 2, fontWeight: FontWeight.w700),
                ),
                Text(
                  '$kLastUpdateOnLabel 5/5/2022',
                  style: TextStyle(
                    fontSize: AppData.shared.getSmallFontSize(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
