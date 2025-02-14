import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/invoice_detai_bloc.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';
import 'package:tmsmobile/data/vos/utility_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/home/payment_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceDetailPage extends StatelessWidget {
  InvoiceDetailPage({super.key, this.billingData});
  final BillingVO? billingData;

  final GlobalKey contentKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InvoiceDetaiBloc(context: context),
      child: Consumer<InvoiceDetaiBloc>(
        builder: (context, bloc, child) => IgnorePointer(
          ignoring: bloc.isDownloadLoading == true,
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: PreferredSize(
                preferredSize: Size(double.infinity, kMargin60),
                child: GradientAppBar(
                  AppLocalizations.of(context)?.kInvoiceDetailLabel ?? '',
                  action: _buildDownloadButton(context),
                )),
            body: Stack(
              children: [
                SingleChildScrollView(
                    child: RepaintBoundary(
                        key: contentKey, child: _buildBody(context))),

                ///download progress loading
                Center(
                  child: AnimatedOpacity(
                    opacity: bloc.isDownloadLoading == false ? 0 : 1,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      width: 150,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMargin10),
                        color: kBlackColor.withValues(alpha: 0.9),
                      ),
                      child: Center(
                          child: Text(
                        'Saving....',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: kTextRegular),
                      )),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Consumer<InvoiceDetaiBloc>(
              builder: (context, bloc, child) => Container(
                  height: kBottomBarHeight,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: Offset(8, 0), blurRadius: 5, color: kGreyColor)
                  ]),
                  child: Center(
                      child: gradientButton(
                          title:
                              AppLocalizations.of(context)?.kMakePaymentLabel,
                          onPress: () {
                            PageNavigator(ctx: context).nextPage(page: PaymentPage());
                          },
                          context: context))),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return Consumer<InvoiceDetaiBloc>(
      builder: (context, bloc, child) => IconButton(
          onPressed: () {
            bloc.savePdf(contentKey);
          },
          icon: Icon(
            Icons.download,
            color: kWhiteColor,
          )),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kMargin12,
        children: [
          10.vGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMargin24),
            child: Column(
              spacing: kMargin12,
              children: [
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kInvoiceNoLabel ?? '',
                    value: billingData?.invoiceCode ?? ''),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kDateLabel ?? '',
                    value: DateFormatter.formatDate(
                        billingData?.date ?? DateTime.now())),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kTenantNameLabel ?? '',
                    value: billingData?.tenant ?? ''),
                _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                    value: billingData?.shop?.first ?? ''),
                _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kPhoneNumberLabel ?? '',
                    value: '-'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kMonthLabel ?? '',
                    value: billingData?.month ?? '-'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kDueDateLabel ?? '',
                    value: DateFormatter.formatDate(
                        billingData?.dueDate ?? DateTime.now())),
              ],
            ),
          ),
          1.vGap,
          billingData?.invoiceType == 'Monthly'
              ? _buildMonthyInvoice(context)
              : _buildMaintenanceInvoice(context),
          _buildPrice(context),
          10.vGap
        ],
      ),
    );
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
            softWrap: true,
            textAlign: TextAlign.end,
            style:
                TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }

  Widget _buildMaintenanceInvoice(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(kMargin5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 5,
            color: kGreyColor,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
              height: kSize46,
              width: double.infinity,
              padding: EdgeInsets.only(left: kMarginMedium2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kMargin5),
                    topRight: Radius.circular(kMargin5)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)?.kMaintenanceInvoiceLabel ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: kTextRegular,
                      color: kWhiteColor),
                ),
              )),
          ListView.builder(
              itemCount: billingData?.utilities?.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: kMarginMedium2, vertical: kMargin10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildMaintenanceInvoiceChild(
                        context, billingData?.utilities?[index] ?? UtilityVO()),
                    index == 1 ? SizedBox.shrink() : Divider()
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildMaintenanceInvoiceChild(BuildContext context, UtilityVO data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMargin10),
      child: Column(
        spacing: kMargin12,
        children: [
          _buildListDetail(
              title: AppLocalizations.of(context)?.kDetailLabel ?? '',
              value: data.title ?? ''),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kUnitLabel ?? '',
              value: data.unit ?? ''),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kQtyLabel ?? '',
              value: '${data.qty ?? 0}'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kTaxPercentLabel ?? '',
              value: '-'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kRateLabel ?? '',
              value: '${data.rate ?? 0}'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kAmountLabel ?? '',
              value: '${data.amount ?? 0} MMK'),
        ],
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
      padding:
          EdgeInsets.symmetric(horizontal: kMarginMedium2, vertical: kMargin10),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(kMargin5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 5,
            color: kGreyColor,
          )
        ],
      ),
      child: Column(
        spacing: kMargin12,
        children: [
          _buildListDetail(
              title: AppLocalizations.of(context)?.kSubTotal ?? '',
              value: '${billingData?.subTotal ?? 0} MMK'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kTaxLabel ?? '',
              value: '${billingData?.tax ?? 0} MMK'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kLateFeeLabel ?? '',
              value: '${billingData?.lateFee ?? 0} MMK'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kGrandTotalLabel ?? '',
              value: '${billingData?.grandTotal ?? 0} MMK'),
        ],
      ),
    );
  }

  Widget _buildMonthyInvoice(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(kMargin5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 5,
            color: kGreyColor,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
              height: kSize46,
              width: double.infinity,
              padding: EdgeInsets.only(left: kMarginMedium2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kMargin5),
                    topRight: Radius.circular(kMargin5)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)?.kMonthlyInvoiceLabel ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: kTextRegular,
                      color: kWhiteColor),
                ),
              )),
          12.vGap,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                AppLocalizations.of(context)?.kElectricFeeLabel ?? '',
                style: TextStyle(
                    fontFamily: AppData.shared.fontFamily2,
                    fontSize: AppData.shared.getMediumFontSize(),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          12.vGap,
          ListView.builder(
              itemCount: billingData?.utilities?.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  spacing: kMargin12,
                  children: [
                    _buildMonthyInvoiceChild(
                        context, billingData?.utilities?[index] ?? UtilityVO()),
                    Divider(),
                    1.vGap
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildMonthyInvoiceChild(BuildContext context, UtilityVO data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: kMargin12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kYesbLabel,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: kTextRegular),
            ),
            Text(
              kPreviousMonthLabel,
              style: TextStyle(fontSize: kTextRegular),
            ),
            Text(
              kThisMonthLabel,
              style: TextStyle(fontSize: kTextRegular),
            )
          ],
        ),
        Column(
          spacing: kMargin12,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              kUnitLabel,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: kTextRegular),
            ),
            Text(
              '${data.previousMonth ?? 0}',
              style: TextStyle(fontSize: kTextRegular),
            ),
            Text(
              '${data.thisMonth ?? 0}',
              style: TextStyle(fontSize: kTextRegular),
            )
          ],
        ),
        Column(
          spacing: kMargin12,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              kRateLabel,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: kTextRegular),
            ),
            Text(
              '${data.amount} MMK'.replaceRange(2, 2, ','),
              style: TextStyle(fontSize: kTextRegular),
            ),
            Text(
              '-',
              style: TextStyle(fontSize: kTextRegular),
            )
          ],
        ),
      ],
    );
  }
}


// _buildListDetail(
                //     title: AppLocalizations.of(context)?.kRentalFeeLabel ?? '',
                //     value: '-'),
                // _buildListDetail(
                //     title:
                //         AppLocalizations.of(context)?.kCommercialTaxLabel ?? '',
                //     value: '-'),
                // _buildListDetail(
                //     title: AppLocalizations.of(context)?.kAdvertisingFeeLabel ??
                //         '',
                //     value: '-'),
                // _buildListDetail(
                //     title: AppLocalizations.of(context)
                //             ?.kCleanAndSecurityFeeLabel ??
                //         '',
                //     value: '-'),
                // _buildListDetail(
                //     title: AppLocalizations.of(context)
                //             ?.kAirconAndElevatorFeeLabel ??
                //         '',
                //     value: '-'),
                // _buildListDetail(
                //     title: AppLocalizations.of(context)
                //             ?.kPetAndMosquitoControlLabel ??
                //         '',
                //     value: '-'),
                // _buildListDetail(
                //     title: AppLocalizations.of(context)
                //             ?.kBillBoardAdvertisingChargeLabel ??
                //         '',
                //     value: '-'),