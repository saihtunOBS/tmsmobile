import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/invoice_detai_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class InvoiceDetailPage extends StatelessWidget {
  InvoiceDetailPage({super.key});

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
                    child:
                        RepaintBoundary(key: contentKey, child: _buildBody(context))),

                ///download progress loading
                Center(
                  child: AnimatedOpacity(
                    opacity: bloc.isDownloadLoading == false ? 0 : 1,
                    duration: Duration(milliseconds: 300),
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
                            fontSize: AppData.shared.getSmallFontSize()),
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
                          title: AppLocalizations.of(context)?.kMakePaymentLabel, onPress: () {},context: context))),
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
                _buildListDetail(title: AppLocalizations.of(context)?.kInvoiceNoLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kDateLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kTenantNameLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kRoomShopNameLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kPhoneNumberLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kMonthLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kDueDateLabel ?? '', value: 'value'),
              ],
            ),
          ),
          1.vGap,
          _buildMaintenanceInvoice(context),
          _buildMonthyInvoice(context),
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
              padding: EdgeInsets.only(left: kMarginMedium2, top: kMargin12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kMargin5),
                    topRight: Radius.circular(kMargin5)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Text(
                AppLocalizations.of(context)?.kMaintenanceInvoiceLabel ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppData.shared.getSmallFontSize(),
                    color: kWhiteColor),
              )),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: kMarginMedium2, vertical: kMargin10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildMaintenanceInvoiceChild(context),
                    index == 1 ? SizedBox.shrink() : Divider()
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildMaintenanceInvoiceChild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMargin10),
      child: Column(
        spacing: kMargin12,
        children: [
          _buildListDetail(
              title: AppLocalizations.of(context)?.kDetailLabel ?? '',
              value:
                  'this is description this is descriptionthis is descriptionthis is descriptionthis is descriptionthis is descriptionthis is descriptionthis is description'),
          _buildListDetail(title: AppLocalizations.of(context)?.kUnitLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kQtyLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kTaxPercentLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kRateLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kAmountLabel ?? '', value: 'value'),
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
          _buildListDetail(title: AppLocalizations.of(context)?.kSubTotal ?? '', value: 'value'),
          _buildListDetail(title:AppLocalizations.of(context)?. kTaxLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kLateFeeLabel ?? '', value: 'value'),
          _buildListDetail(title: AppLocalizations.of(context)?.kGrandTotalLabel ?? '', value: 'value'),
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
              padding: EdgeInsets.only(left: kMarginMedium2, top: kMargin12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kMargin5),
                    topRight: Radius.circular(kMargin5)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Text(
                AppLocalizations.of(context)?.kMonthlyInvoiceLabel ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppData.shared.getSmallFontSize(),
                    color: kWhiteColor),
              )),
          Container(
            margin: EdgeInsets.only(
                left: kMarginMedium2, right: kMarginMedium2, top: kMargin10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: kMargin12,
              children: [
                _buildListDetail(title: AppLocalizations.of(context)?.kRentalFeeLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kCommercialTaxLabel ?? '', value: 'value'),
                _buildListDetail(title: AppLocalizations.of(context)?.kAdvertisingFeeLabel ?? '', value: 'value'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kCleanAndSecurityFeeLabel ?? '', value: 'value'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kAirconAndElevatorFeeLabel ?? '', value: 'value'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kPetAndMosquitoControlLabel ?? '', value: 'value'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kBillBoardAdvertisingChargeLabel ?? '', value: 'value'),
                Text(
                  AppLocalizations.of(context)?.kElectricFeeLabel ?? '',
                  style: TextStyle(
                      fontFamily: AppData.shared.fontFamily2,
                      fontSize: AppData.shared.getMediumFontSize(),
                      fontWeight: FontWeight.w600),
                ),
                1.vGap
              ],
            ),
          ),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  spacing: kMargin12,
                  children: [_buildMonthyInvoiceChild(context), Divider(), 1.vGap],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildMonthyInvoiceChild(BuildContext context) {
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
              '10',
              style: TextStyle(fontSize: kTextRegular),
            ),
            Text(
              '6',
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
              '50000 MMK'.replaceRange(2, 2, ','),
              style: TextStyle(fontSize: kTextRegular),
            ),
            Text(
              '',
              style: TextStyle(fontSize: kTextRegular),
            )
          ],
        ),
      ],
    );
  }
}
