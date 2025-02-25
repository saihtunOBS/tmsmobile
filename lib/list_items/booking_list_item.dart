import 'package:flutter/material.dart';
import 'package:tmsmobile/data/app_data/app_data.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/cache_image.dart';

import '../utils/colors.dart';

class BookingListItem extends StatelessWidget {
  const BookingListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kMarginMedium2),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              color: kGreyColor,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 163,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: cacheImage(
                  'https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2024/12/04/f8df0173d8414f47ad9b7b34021d1a29_8-bangkok-top-rooftop-bars-for-stunning-views-and-cool-breezes_%287%29.jpg'),
            ),
          ),
          6.vGap,
          Text(
            'Rooftop',
            style: TextStyle(
                fontFamily: AppData.shared.fontFamily2,
                fontSize: kTextRegular22 - 2,
                fontWeight: FontWeight.bold),
          ),
          5.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '100000 MMK',
              ),
              Text(
                '1 Section',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
