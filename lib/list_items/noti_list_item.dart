import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/app_data/app_data.dart';

class NotiListItem extends StatelessWidget {
  const NotiListItem({
    super.key,
  });

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
                  borderRadius: BorderRadius.circular(kMarginMedium),
                  color: kOrangeColor),
              child: Center(
                child: Icon(
                  CupertinoIcons.wrench,
                  color: kWhiteColor,
                  size: kMarginMedium2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: kMarginMedium),
                padding: EdgeInsets.only(right: kMargin12,left: kMargin12,bottom: kMargin12,top: kMargin5),
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
                      'Electric Fault',
                      style: TextStyle(
                          fontSize: kTextRegular,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Eget neque gravida tellus vitae quis ar .....',
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
                              borderRadius:
                                  BorderRadius.circular(kMargin5 + 1)),
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
              'Dec 12, 2024',
              style: TextStyle(fontSize: kTextRegular),
            )
          ],
        )
      ],
    );
  }
}
