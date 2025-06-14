import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

class SectionListItem extends StatelessWidget {
  const SectionListItem({
    super.key,
    required this.fromTime,
    required this.toTime,
  });

  final String fromTime;
  final String toTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMargin10 - 3),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(kMargin6)),
      child: Column(
        children: [
          Container(
            height: 36,
            width: double.infinity,
            color: kPrimaryColor,
            child: Center(
              child: Text(
                'Section',
                style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        AppLocalizations.of(context)?.kFromLabel ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kTextSmall - 1),
                      ),
                    ),
                    6.vGap,
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 16,
                        ),
                        3.hGap,
                        Text(
                          fromTime,
                          style: TextStyle(
                              color: kBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: kTextSmall),
                        ),
                      ],
                    )
                  ],
                ),
              )),
              Container(
                height: 53,
                width: 1,
                color: kBlackColor,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        AppLocalizations.of(context)?.kToLabel ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kTextSmall - 1),
                      ),
                    ),
                    6.vGap,
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 16,
                        ),
                        3.hGap,
                        Text(
                          toTime,
                          style: TextStyle(
                              color: kBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: kTextSmall),
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
