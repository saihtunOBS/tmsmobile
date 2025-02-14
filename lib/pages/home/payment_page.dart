import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';

import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            AppLocalizations.of(context)?.kBackLabel ?? '',
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          16.vGap,
          Container(
            height: 180,
            margin: EdgeInsets.symmetric(horizontal: kMargin60),
            child: Image.asset(
              kPaymentImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            '300000 MMK',
            style: TextStyle(
                fontSize: kTextRegular28,
                fontWeight: FontWeight.w700,
                color: kPrimaryColor),
          ),
          Text(
            'Remaining amount',
            style: TextStyle(
              fontSize: kTextRegular13,
            ),
          ),
          15.vGap,
          Container(
            height: 31,
            margin: EdgeInsets.symmetric(horizontal: kMargin60),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kMarginMedium),
                color: kPrimaryColor),
            child: Center(
              child: Text(
                'Used for : Utilities',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: kWhiteColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
