import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/utils/date_formatter.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class ResidentListItem extends StatelessWidget {
  const ResidentListItem({
    super.key,
    required this.houseHoldData,
    required this.index,
  });
  final HouseHoldVO houseHoldData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: kMargin12 + 4,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            color: kDarkBlueColor,
            width: MediaQuery.of(context).size.width / 2.15,
            height: kSize43,
            child: Center(
              child: Text(
                'Owner',
                style: TextStyle(
                    decoration: index == 0
                        ? index == 1
                            ? TextDecoration.underline
                            : TextDecoration.none
                        : TextDecoration.none,
                    decorationThickness: 2.0,
                    color: index == 0 ? kWhiteColor : Colors.black,
                    fontWeight:
                        index == 0 ? FontWeight.w700 : FontWeight.normal,
                    fontSize: kTextRegular),
              ),
            ),
          ),
          Text(
            (houseHoldData.resident?[index].residentName ?? ''),
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            (houseHoldData.resident?[index].gender ?? ''),
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            DateFormatter.formatDate(
                houseHoldData.resident?[index].dateOfBirth as DateTime),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Text(
            (houseHoldData.resident?[index].race ?? ''),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Text(
            (houseHoldData.resident?[index].nationality ?? ''),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Text(
            (houseHoldData.resident?[index].nrc ?? ''),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Text(
            (houseHoldData.resident?[index].contactNumber ?? ''),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Text(
            '-',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Text(
            '-',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
