import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/app_data/app_data.dart';


class ComplainListItem extends StatelessWidget {
  const ComplainListItem({
    super.key,
    this.isLast,
    this.data,
  });
  final bool? isLast;
  final ComplaintVO? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kMargin12,
      ),
      child: Column(
        spacing: kMargin5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.kCompliantLabel ?? '',
            style: TextStyle(
                fontSize: AppData.shared.getSmallFontSize(), fontWeight: FontWeight.w700),
          ),
          Text(
            data?.complaint ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: kTextRegular),
          ),
          Row(
            children: [
              Spacer(),
              Container(
                height: kSize28,
                padding: EdgeInsets.symmetric(horizontal: kMargin12),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kMargin5 + 1)),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)?.kViewDetailLabel ?? '',
                    style: TextStyle(
                        fontSize: kTextSmall,
                        color: kWhiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
          isLast == true ? SizedBox() : Divider()
        ],
      ),
    );
  }
}
