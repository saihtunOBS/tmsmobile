import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/home/invoice_detail_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/appbar.dart';

class BillingInvoicePage extends StatelessWidget {
  const BillingInvoicePage({super.key});

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
                  PageNavigator(ctx: context)
                      .nextPage(page: InvoiceDetailPage());
                }),
          )),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: kMargin24, right: kMargin24,),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: kMargin12,
          children: [
            1.vGap,
            Center(
              child: Text(
                AppLocalizations.of(context)?.kPaymentLabel ?? '',
                style: TextStyle(fontSize: kTextRegular18),
              ),
            ),
            Center(
              child: Text(
                '650000 MMK'.replaceRange(2, 2, ','),
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: kTextRegular28),
              ),
            ),
            10.vGap,
            _buildListDetail(title: AppLocalizations.of(context)?.kTransactionTimeLabel ?? '', value: 'value'),
            _buildListDetail(title: AppLocalizations.of(context)?.kInvoiceNoLabel ?? '', value: 'value'),
            _buildListDetail(title: AppLocalizations.of(context)?.kTenantNameLabel ?? '', value: 'value'),
            _buildListDetail(title: AppLocalizations.of(context)?.kRoomShopNameLabel ?? '', value: 'value'),
            _buildListDetail(title: AppLocalizations.of(context)?.kPhoneNumberLabel ?? '', value: 'value'),
            _buildListDetail(title: AppLocalizations.of(context)?.kTransactionTypeLabel ?? '', value: 'value'),
            _buildListDetail(title: AppLocalizations.of(context)?.kPaymentTypeLabel ?? '', value: 'value'),
            _buildListDetail(title: AppLocalizations.of(context)?.kTotalAmountLabel ?? '', value: 'value'),

            5.vGap,

            ///partially paid history
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                AppLocalizations.of(context)?.kPartiallyPaidHistoryLabel ?? '',
                style: TextStyle(
                    fontSize: kTextRegular, fontWeight: FontWeight.w700),
              ),
              10.vGap,
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buidPartiallyPaidHistory(context);
                  }),
            ])
          ],
        ),
      ),
    );
  }

  Widget _buildListDetail({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular),
        ),
        Text(
          value,
          style: TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w700),
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
          _buildListDetail(title: AppLocalizations.of(context)?.kDateLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kTotalAmountLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kPartiallyAmountLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kRemainingAmountLabel ?? '', value: 'value')
        ],
      ),
    );
  }
}
