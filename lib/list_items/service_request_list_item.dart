import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

class ServiceRequestListItem extends StatelessWidget {
  const ServiceRequestListItem(
      {super.key, required this.statusColor, required this.status, this.isFillOut});
  final int statusColor;
  final String status;
  final bool? isFillOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kMarginMedium),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: kMarginMedium),
            padding: EdgeInsets.all(kMargin12),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID #12345',
                      style: TextStyle(
                        fontSize: kTextRegular2x,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: kSize26,
                      padding: EdgeInsets.symmetric(horizontal: kMargin12),
                      decoration: BoxDecoration(
                          color: _filterStatusColor(status: statusColor)
                              .withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(kMarginMedium14)),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                              fontSize: kTextSmall,
                              color: _filterStatusColor(status: statusColor)),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(),
                Text(
                  'Request for',
                  style: TextStyle(
                    fontSize: kTextRegular13,
                  ),
                ),
                Text(
                  isFillOut == true ? 'Fill Out' : 'Electric Fault',
                  style: TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.w700),
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
                          borderRadius: BorderRadius.circular(kMargin5 + 1)),
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

  Color _filterStatusColor({required int status}) {
    switch (status) {
      case 0:
        return kBlackColor;
      case 1:
        return kOrangeColor;
      case 2:
        return kGreenColor;
      case 3:
        return kPrimaryColor;
      case 4:
        return kYellowColor;
      case 5:
        return kPurpleColor;
      default:
        return kPrimaryColor;
    }
  }
}
