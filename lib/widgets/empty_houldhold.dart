import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/app_data/app_data.dart';
import '../utils/colors.dart';

class EmptyHousehold extends StatelessWidget {
  const EmptyHousehold({super.key, this.onPress});

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: kMargin6,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: kSize120,
            height: kSize120,
            child: Image.asset(kNoRegistrationImage),
          ),
          Text(
            AppLocalizations.of(context)?.kNoRegisterYetLabel ?? '',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: AppData.shared.getRegularFontSize()),
          ),
          5.vGap,
          GestureDetector(
            onTap: () => onPress!(),
            child: Container(
              height: 50,
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
                child: Text(
                  AppLocalizations.of(context)?.kHouseholdRegistrationFormLabel ??
                      '',
                  style: TextStyle(fontSize: AppData.shared.getRegularFontSize(), color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
