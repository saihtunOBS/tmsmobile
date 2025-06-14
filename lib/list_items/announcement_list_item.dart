import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

import '../utils/html_text.dart';

class AnnouncementListItem extends StatelessWidget {
  const AnnouncementListItem({
    super.key,
    required this.data,
  });
  final AnnouncementVO data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kMarginMedium2),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: kMarginMedium),
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(kMargin6),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 5,
                    color: kGreyColor,
                  )
                ]),
            child: Column(
              spacing: kMargin5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 42,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: kMarginMedium2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kMargin6),
                        topRight: Radius.circular(kMargin6)),
                    gradient: LinearGradient(
                      colors: [kPrimaryColor, kThirdColor],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.title ?? '',
                      style: TextStyle(
                          fontSize: kTextRegular2x,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                  child: Text(
                    htmlParser(data.description ?? ''),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(fontSize: kTextRegular - 1),
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      height: kSize28,
                      padding: EdgeInsets.symmetric(horizontal: kMargin12),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(kMargin12),
                              bottomRight: Radius.circular(kMargin6))),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)?.kReadMoreLabel ?? '',
                          style: TextStyle(
                              fontSize: kTextSmall,
                              color: kWhiteColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              Text(
                DateFormatter.formatDate2(data.createdAt ?? DateTime.now()),
                style: TextStyle(
                    fontSize: kMarginMedium14 - 1, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
