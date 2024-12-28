import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

class AnnouncementListItem extends StatelessWidget {
  const AnnouncementListItem({
    super.key,
  });

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
                    blurRadius: 13,
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
                      right: kMarginMedium2,
                      top: kMargin10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kMargin6),
                        topRight: Radius.circular(kMargin6)),
                    gradient: LinearGradient(
                      colors: [kPrimaryColor, kThirdColor],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Text(
                    'New properties for rent',
                    style: TextStyle(color: kWhiteColor,fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                  child: Text(
                    'Lorem ipsum dolor sit amet consectetur. Eget neque gravida tellus vitae quis ar .....',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(fontSize: kTextRegular),
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 28,
                      padding: EdgeInsets.symmetric(horizontal: kMargin12),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(kMargin12),
                              bottomRight: Radius.circular(kMargin6))),
                      child: Center(
                        child: Text(
                          kViewDetailLabel,
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
                'Dec 12, 2024',
                style: TextStyle(fontSize: kTextRegular13),
              )
            ],
          )
        ],
      ),
    );
  }
}
