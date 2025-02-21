import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/number_extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/home/invoice_detail_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/app_data/app_data.dart';
import '../../widgets/appbar.dart';

class BillingInvoicePage extends StatelessWidget {
  const BillingInvoicePage(
      {super.key, required this.status, required this.data});
  final int status;
  final BillingVO data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            AppLocalizations.of(context)?.kDetailLabel ?? '',
          )),
      body: _buildBody(context),
      bottomNavigationBar: SizedBox(
          height: kBottomBarHeight,
          child: Center(
            child: gradientButton(
                title: AppLocalizations.of(context)?.kViewInvoiceDetailLabel,
                onPress: () {
                  PageNavigator(ctx: context).nextPage(
                      page: InvoiceDetailPage(
                    billingData: data,
                  ));
                },
                context: context),
          )),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: kMargin24,
        right: kMargin24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.vGap,
            status == 1
                ? SizedBox.shrink()
                : Column(
                    children: [
                      Center(
                        child: Text(
                          AppLocalizations.of(context)?.kPaymentLabel ?? '',
                          style: TextStyle(
                              fontSize: AppData.shared.getRegularFontSize()),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${data.grandTotal?.toInt().toString().format} MMK',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: kTextRegular28),
                        ),
                      ),
                      10.vGap,
                    ],
                  ),
            status == 1
                ? SizedBox.shrink()
                : _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kTransactionTimeLabel ??
                            '',
                    value: '-'),
            12.vGap,
            _buildListDetail(
                title: AppLocalizations.of(context)?.kInvoiceNoLabel ?? '',
                value: data.invoiceCode ?? ''),
            12.vGap,
            _buildListDetail(
                title: AppLocalizations.of(context)?.kTenantNameLabel ?? '',
                value: data.tenant ?? ''),
            12.vGap,
            _buildListDetail(
                title: AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                value: data.shop?.first ?? ''),
            12.vGap,
            _buildListDetail(
                title: AppLocalizations.of(context)?.kPhoneNumberLabel ?? '',
                value: '-'),
            12.vGap,
            _buildListDetail(
                title:
                    AppLocalizations.of(context)?.kTransactionTypeLabel ?? '',
                value: data.transactionType == 0 ? 'Cash' : 'Bank'),
            status == 2 ? 0.vGap : 12.vGap,
            Visibility(
                visible: status != 2,
                child: _status(
                  AppLocalizations.of(context)?.kStatusLabel ?? '',
                  true,
                )),
            8.vGap,
            _status(
                AppLocalizations.of(context)?.kPaymentTypeLabel ?? '', false,
                isPartially: status == 1 ? true : false),
            10.vGap,
            status == 1
                ? SizedBox.shrink()
                : _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kTotalAmountLabel ?? '',
                    value: '${data.grandTotal?.toInt().toString().format} MMK'),

            12.vGap,

            ///partially paid history
            // status == 2
            //     ? SizedBox.shrink()
            //     : Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //             Text(
            //               AppLocalizations.of(context)
            //                       ?.kPartiallyPaidHistoryLabel ??
            //                   '',
            //               style: TextStyle(
            //                   fontSize: kTextRegular,
            //                   fontWeight: FontWeight.w700),
            //             ),
            //             10.vGap,
            //             ListView.builder(
            //                 shrinkWrap: true,
            //                 itemCount: 3,
            //                 physics: NeverScrollableScrollPhysics(),
            //                 itemBuilder: (context, index) {
            //                   return _buidPartiallyPaidHistory(context);
            //                 }),
            //           ])
          ],
        ),
      ),
    );
  }

  Widget _status(String value, bool isStatus, {bool? isPartially}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: kTextRegular),
        ),
        Container(
          height: kSize26,
          padding: EdgeInsets.symmetric(horizontal: kMargin12),
          decoration: BoxDecoration(
              color: _filterStatusColor(status: status).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(kMarginMedium14)),
          child: Center(
            child: Text(
              status == 2
                  ? 'Fully Paid'
                  : isPartially == true
                      ? 'Partially Paid'
                      : 'Unpaid',
              style: TextStyle(
                  fontSize: kTextSmall,
                  fontWeight: FontWeight.w600,
                  color: isStatus == true
                      ? _filterStatusColor(status: status == 2 ? 2 : 0)
                      : _filterStatusColor(status: status)),
            ),
          ),
        ),
      ],
    );
  }

  Color _filterStatusColor({required int status}) {
    switch (status) {
      case 0:
        return kRedColor;
      case 1:
        return kOrangeColor;
      case 2:
        return kGreenColor;
      default:
        return kPrimaryColor;
    }
  }

  Widget _buildListDetail({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: TextStyle(fontSize: kTextRegular),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style:
                TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }

  Widget _buidPartiallyPaidHistory(BuildContext context) {
    return Container(
      // height: kSize136 + 5,
      padding: EdgeInsets.all(kMargin10),
      margin: EdgeInsets.only(bottom: kMargin6),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kGreyColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(kMargin5 - 1)),
      child: Column(
        spacing: kMargin12,
        children: [
          _buildListDetail(
              title: AppLocalizations.of(context)?.kDateLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kTotalAmountLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kPartiallyAmountLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kRemainingAmountLabel ?? '',
              value: 'value')
        ],
      ),
    );
  }
}
