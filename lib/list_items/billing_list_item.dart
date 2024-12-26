import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

class BillingListItem extends StatelessWidget {
  const BillingListItem(
      {super.key, required this.statusColor, required this.status});
  final int statusColor;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: kMarginMedium2),
      padding: EdgeInsets.all(kMargin12),
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(kMargin6),
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 2),
              blurRadius: 13,
              color: kGreyColor,
            )
          ]),
      child: Column(
        spacing: kMargin5,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dec / 12 / 2024',
                style: TextStyle(fontSize: kTextRegular13, color: kThirdColor),
              ),
              Container(
                height: 26,
                padding: EdgeInsets.symmetric(horizontal: kMargin12),
                decoration: BoxDecoration(
                    color: _filterStatusColor(status: statusColor)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(kMarginMedium14)),
                child: Text(
                  status,
                  style: TextStyle(
                      fontSize: kTextSmall,
                      color: _filterStatusColor(status: statusColor)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MT #00001',
                style: TextStyle(
                  fontSize: kTextRegular13,
                ),
              ),
              Text(
                '600000 MMK',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kMaintenanceInvoiceLabel,
                style: TextStyle(fontSize: kTextRegular13),
              ),
              Text(
                '$kDueDateLabel 11/12/2024',
                style: TextStyle(fontSize: kTextSmall),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#C001',
                style: TextStyle(fontSize: kTextRegular13),
              ),
              Container(
                height: 26,
                padding: EdgeInsets.symmetric(horizontal: kMargin12),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kMargin5 + 1)),
                child: Center(
                  child: Text(
                    kDetailLabel,
                    style: TextStyle(fontSize: kTextSmall, color: kWhiteColor,fontWeight: FontWeight.w700),
                  ),
                ),
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
        return kPrimaryColor;
      case 1:
        return kYellowColor;
      default:
        return kPrimaryColor;
    }
  }
}
