import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/notification_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotiListItem extends StatelessWidget {
  const NotiListItem({
    super.key,
    required this.data,
  });
  final NotificationVO data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: kMarginMedium,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //  borderRadius: BorderRadius.circular(kMarginMedium + 2),
                  color: kGreenColor),
              child: Center(
                child: Icon(
                  Icons.notification_add,
                  color: kWhiteColor,
                  size: kMarginMedium2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: kMarginMedium),
                padding: EdgeInsets.only(
                    right: kMargin12,
                    left: kMargin12,
                    bottom: kMargin12,
                    top: kMargin5),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(kMargin6),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 13,
                        color: kGreyColor,
                      )
                    ]),
                child: Column(
                  spacing: kMargin5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.referenceType == 'Announcement'
                          ? data.referenceData?.title ?? ''
                          : 'Complaints',
                      style: TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      data.referenceType == 'Announcement'
                          ? data.referenceData?.description ?? ''
                          : data.referenceData?.complaints ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(fontSize: kTextRegular - 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        data.referenceType == 'Announcement'
                          ? Spacer() : complaintStatus(data.referenceData?.status ?? 1),
                        Container(
                          height: kSize28,
                          padding: EdgeInsets.symmetric(horizontal: kMargin12),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.circular(kMargin5 + 1)),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)?.kViewDetailLabel ??
                                  '',
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
            ),
          ],
        ),
        Row(
          children: [
            Spacer(),
            Text(
              DateFormatter.formatDate2(data.updatedAt ?? DateTime.now()),
              style: TextStyle(
                  fontSize: kMarginMedium14 - 1, fontWeight: FontWeight.bold),
            )
          ],
        ),
        15.vGap
      ],
    );
  }
}

Widget complaintStatus(int status) {
  return Container(
    height: 24,
    padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: status == 1
            ? kGreyColor.withValues(alpha: 0.5)
            : status == 2
                ? kYellowColor.withValues(alpha: 0.12)
                : kPrimaryColor.withValues(alpha: 0.12)),
    child: Center(
      child: Text(
        status == 1
            ? 'Pending'
            : status == 2
                ? 'Processing'
                : 'Solved',
        style: TextStyle(
            color: status == 1
                ? kBlackColor
                : status == 2
                    ? kYellowColor
                    : kPrimaryColor,fontSize: kMarginMedium14 - 1, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
