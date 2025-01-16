import 'package:flutter/material.dart';
import 'package:tmsmobile/network/requests/household_registration_request.dart';
import 'package:tmsmobile/utils/date_formatter.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class ResidentListItem extends StatelessWidget {
  const ResidentListItem({
    super.key,
    required this.houseHoldData,
    required this.index,
  });
  final HouseHoldInformation houseHoldData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: kMarginMedium2,
        children: [
          Container(
            color: kDarkBlueColor,
            width: MediaQuery.of(context).size.width / 2,
            height: kSize43,
            child: Center(
              child: Text(
                index == 0 ? 'Owner' : 'Resident',
                style: TextStyle(
                    decoration: index == 0
                        ? index == 1
                            ? TextDecoration.underline
                            : TextDecoration.none
                        : TextDecoration.none,
                    decorationThickness: 2.0,
                    color: index == 0 ? kWhiteColor : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular),
              ),
            ),
          ),
          Text(
            (houseHoldData.name ?? ''),
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2.0,
                fontWeight: FontWeight.bold,
                fontSize: kTextRegular),
          ),
          Text(
            (houseHoldData.gender ?? ''),
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: kTextRegular),
          ),
          Text(
            DateFormatter.formatDate(
                houseHoldData.dateOfBirth ?? DateTime.now()),
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: kTextRegular),
          ),
          Text(
            (houseHoldData.race ?? ''),
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: kTextRegular),
          ),
          Text(
            (houseHoldData.nationality ?? ''),
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: kTextRegular),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2.3,
            child: Text(
              (houseHoldData.nrc ?? ''),
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: kTextRegular),
            ),
          ),
          Text(
            (houseHoldData.contactNumber ?? ''),
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: kTextRegular),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2.3,
            child: Text(
              houseHoldData.type == 1 ? houseHoldData.email ?? '' : '-',
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: kTextRegular),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2.3,
            child: Text(
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              houseHoldData.type == 2
                  ? houseHoldData.relatedToOwner ?? ''
                  : '-',
              style: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: kTextRegular),
            ),
          ),
        ],
      ),
    );
  }
}
