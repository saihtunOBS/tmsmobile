import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';
import 'package:tmsmobile/extension/number_extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BillingListItem extends StatelessWidget {
  const BillingListItem({super.key, this.biling});

  final BillingVO? biling;

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
              offset: Offset(0, 4),
              blurRadius: 5,
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
                DateFormatter.formatDate(biling?.date ?? DateTime.now()),
                style: TextStyle(fontSize: kTextRegular, color: kThirdColor),
              ),
              Container(
                height: kSize26,
                padding: EdgeInsets.symmetric(horizontal: kMargin12),
                decoration: BoxDecoration(
                    color: _filterStatusColor(status: biling?.status ?? 0)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(kMarginMedium14)),
                child: Center(
                  child: Text(
                    biling?.status == 0
                        ? 'Unpaid'
                        : biling?.status == 1
                            ? 'Partially Paid'
                            : 'Paid',
                    style: TextStyle(
                        fontSize: kTextSmall,
                        fontWeight: FontWeight.w600,
                        color: _filterStatusColor(status: biling?.status ?? 0)),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                biling?.invoiceCode ?? '',
                style: TextStyle(
                  fontSize: kTextRegular,
                ),
              ),
              Text(
                '${biling?.grandTotal?.toInt().toString().format} MMK',
                style: TextStyle(
                    fontSize: kTextRegular, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                biling?.invoiceType ?? '',
                style: TextStyle(fontSize: kTextRegular),
              ),
              Text(
                biling?.status == 2
                    ? 'Paid Date ${DateFormatter.formatDate(biling?.date ?? DateTime.now())}'
                    : '$kDueDateLabel ${DateFormatter.formatDate(biling?.dueDate ?? DateTime.now())}',
                style: TextStyle(fontSize: kTextSmall),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  '#${biling?.shop?.first ?? ''}',
                  style: TextStyle(fontSize: kTextRegular),
                ),
              ),
              Container(
                height: kSize26,
                padding: EdgeInsets.symmetric(horizontal: kMargin12),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kMargin5 + 1)),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)?.kDetailLabel ?? '',
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
    );
  }

  Color _filterStatusColor({required int status}) {
    switch (status) {
      case 0:
        return kPrimaryColor;
      case 1:
        return kOrangeColor;
      case 2:
        return kGreenColor;
      default:
        return kPrimaryColor;
    }
  }
}
