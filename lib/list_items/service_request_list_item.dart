import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ServiceRequestListItem extends StatelessWidget {
  const ServiceRequestListItem(
      {super.key, required this.status, this.isFillOut, this.data});
  final int status;
  final bool? isFillOut;
  final ServiceRequestVo? data;

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
                    blurRadius: 5,
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
                    Expanded(
                      child: Text(
                        'ID #${data?.id}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: kTextRegular,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    40.hGap,
                    Container(
                      height: kSize26,
                      padding: EdgeInsets.symmetric(horizontal: kMargin12),
                      decoration: BoxDecoration(
                          color: isFillOut == true
                              ? _filterFillOutStatusColor(status: status)
                                  .withValues(alpha: 0.12)
                              : _filterStatusColor(status: status)
                                  .withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(kMarginMedium14)),
                      child: Center(
                        child: Text(
                          isFillOut == true
                              ? _filterFillOutStatus(status: status)
                              : _filterStatus(status: status),
                          style: TextStyle(
                              fontSize: kTextSmall,
                              color: isFillOut == true
                                  ? _filterFillOutStatusColor(status: status)
                                  : _filterStatusColor(status: status)),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(),
                Text(
                  'Request for',
                  style: TextStyle(
                    fontSize: kTextRegular,
                  ),
                ),
                Text(
                  isFillOut == true ? 'Fit Out' : 'Electric Fault',
                  style: TextStyle(
                      fontSize: kTextRegular,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  isFillOut == true
                      ? data?.description ?? ''
                      : data?.description ?? '',
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
          Row(
            children: [
              Spacer(),
              Text(
                isFillOut == true
                    ? DateFormatter.formatDate(
                        data?.createdAt ?? DateTime.now())
                    : data?.status == 1
                        ? DateFormatter.formatStringDate(
                            data?.pendingDate ?? '')
                        : data?.status == 2
                            ? DateFormatter.formatStringDate(
                                data?.surveyDate ?? '')
                            : data?.status == 3
                                ? DateFormatter.formatStringDate(
                                    data?.quotationDate ?? '')
                                : data?.status == 4 || data?.status == 5
                                    ? DateFormatter.formatStringDate(
                                        data?.acceptRejectDate ?? '')
                                    : data?.status == 6
                                        ? DateFormatter.formatStringDate(
                                            data?.pendingDate ?? '')
                                        : DateFormatter.formatStringDate(
                                            data?.finishDate ?? ''),
                style: TextStyle(fontSize: kMarginMedium14),
              )
            ],
          )
        ],
      ),
    );
  }

  Color _filterStatusColor({required int status}) {
    switch (status) {
      case 1:
        return kBlackColor;
      case 2:
        return kOrangeColor;
      case 3:
        return kGreenColor;
      case 4:
        return kRedColor;
      case 5:
        return kPrimaryColor;
      case 6:
        return kYellowColor;
      case 7:
        return kPurpleColor;
      default:
        return kPrimaryColor;
    }
  }

  String _filterStatus({required int status}) {
    switch (status) {
      case 1:
        return 'Pending';
      case 2:
        return 'Survey';
      case 3:
        return 'Quotation';
      case 4:
        return 'Reject';
      case 5:
        return 'Accept';
      case 6:
        return 'Processing';
      case 7:
        return 'Finished';
      default:
        return 'Pending';
    }
  }

  String _filterFillOutStatus({required int status}) {
    switch (status) {
      case 1:
        return 'Pending';
      case 2:
        return 'Approved';
      case 3:
        return 'Close';
      case 4:
        return 'Close';
      default:
        return 'Pending';
    }
  }

  Color _filterFillOutStatusColor({required int status}) {
    switch (status) {
      case 1:
        return kBlackColor;
      case 2:
        return kPrimaryColor;
      case 3:
        return kRedColor;
      case 4:
        return kRedColor;
      default:
        return kPrimaryColor;
    }
  }
}
