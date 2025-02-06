// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/maintenance_quotation_bloc.dart';
import 'package:tmsmobile/data/vos/quotation_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaintenanceQuotationPage extends StatelessWidget {
  const MaintenanceQuotationPage({super.key, required this.quotation, required this.id});
  final QuotationVO quotation;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MaintenanceQuotationBloc(id),
      child: Consumer<MaintenanceQuotationBloc>(
        builder: (context, bloc, child) => Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, kMargin60),
              child: GradientAppBar(
                AppLocalizations.of(context)?.kDetailLabel ?? '',
              )),
          body: Stack(children: [
            _buildBody(context, quotation),

            ///loading
            if (bloc.isLoading == true) LoadingView()
          ]),
          bottomNavigationBar: Container(
              padding: EdgeInsets.only(
                  left: kMarginMedium2,
                  right: kMarginMedium2,
                  bottom: kMargin12),
              height: kBottomBarHeight,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(8, 0), blurRadius: 10, color: kGreyColor)
              ]),
              child: Center(child: _buildAcceptRejectButton(context))),
        ),
      ),
    );
  }

  Widget _buildAcceptRejectButton(BuildContext context) {
    return Consumer<MaintenanceQuotationBloc>(
      builder: (context, bloc, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => bloc.changeStatus(true).then((_) {
              Navigator.of(context).pop();
            }),
            child: Container(
              height: kSize45,
              width: kSize147,
              decoration: BoxDecoration(
                  color: kRedColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(kMargin6)),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)?.kRejectLabel ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppData.shared.getRegularFontSize(),
                      color: kRedColor),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => bloc.changeStatus(false).then((_) {
              Navigator.of(context).pop();
            }),
            child: Container(
              height: kSize45,
              width: kSize147,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(kMargin6)),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)?.kAcceptLabel ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppData.shared.getRegularFontSize(),
                      color: kPrimaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, QuotationVO data) {
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
                    value: '-'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kDateLabel ?? '',
                    value: DateFormatter.formatStringDate(data.date ?? '')),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kTenantNameLabel ?? '',
                    value: data.tenant ?? ''),
                _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                    value: data.shop ?? ''),
                _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kPhoneNumberLabel ?? '',
                    value: '-'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kMonthLabel ?? '',
                    value: '-'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kDueDateLabel ?? '',
                    value: '-'),
              ],
            ),
          ),
          1.vGap,
          _buildMaintenanceInvoice(context),
          //_buildMonthyInvoice(context),
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
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular),
        ),
        kSize40.hGap,
        Expanded(
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

  Widget _buildMaintenanceInvoice(context) {
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
                      fontSize: AppData.shared.getSmallFontSize(),
                      color: kWhiteColor),
                ),
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

  Widget _buildMaintenanceInvoiceChild(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMargin10),
      child: Column(
        spacing: kMargin12,
        children: [
          _buildListDetail(
              title: AppLocalizations.of(context)?.kDetailLabel ?? '',
              value:
                  'this is description this is descriptionthis is descriptionthis is descriptionthis is descriptionthis is descriptionthis is descriptionthis is description'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kUnitLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kQtyLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kTaxPercentLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kRateLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kAmountLabel ?? '',
              value: 'value'),
        ],
      ),
    );
  }

  Widget _buildPrice(context) {
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
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kTaxLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kLateFeeLabel ?? '',
              value: 'value'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kGrandTotalLabel ?? '',
              value: 'value'),
        ],
      ),
    );
  }

  // Widget _buildMonthyInvoice(context) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
  //     decoration: BoxDecoration(
  //       color: kWhiteColor,
  //       borderRadius: BorderRadius.circular(kMargin5),
  //       boxShadow: [
  //         BoxShadow(
  //           offset: Offset(0, 4),
  //           blurRadius: 5,
  //           color: kGreyColor,
  //         )
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Container(
  //             height: kSize46,
  //             width: double.infinity,
  //             padding: EdgeInsets.only(left: kMarginMedium2),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(kMargin5),
  //                   topRight: Radius.circular(kMargin5)),
  //               gradient: LinearGradient(
  //                 colors: [kPrimaryColor, kThirdColor],
  //                 stops: [0.0, 1.0],
  //               ),
  //             ),
  //             child: Align(
  //               alignment: Alignment.centerLeft,
  //               child: Text(
  //                 AppLocalizations.of(context)?.kMonthlyInvoiceLabel ?? '',
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.w700,
  //                     fontSize: AppData.shared.getSmallFontSize(),
  //                     color: kWhiteColor),
  //               ),
  //             )),
  //         Container(
  //           margin: EdgeInsets.only(
  //               left: kMarginMedium2, right: kMarginMedium2, top: kMargin10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             spacing: kMargin12,
  //             children: [
  //               _buildListDetail(
  //                   title: AppLocalizations.of(context)?.kRentalFeeLabel ?? '',
  //                   value: 'value'),
  //               _buildListDetail(
  //                   title:
  //                       AppLocalizations.of(context)?.kCommercialTaxLabel ?? '',
  //                   value: 'value'),
  //               _buildListDetail(
  //                   title: AppLocalizations.of(context)?.kAdvertisingFeeLabel ??
  //                       '',
  //                   value: 'value'),
  //               _buildListDetail(
  //                   title: AppLocalizations.of(context)
  //                           ?.kCleanAndSecurityFeeLabel ??
  //                       '',
  //                   value: 'value'),
  //               _buildListDetail(
  //                   title: AppLocalizations.of(context)
  //                           ?.kAirconAndElevatorFeeLabel ??
  //                       '',
  //                   value: 'value'),
  //               _buildListDetail(
  //                   title: AppLocalizations.of(context)
  //                           ?.kPetAndMosquitoControlLabel ??
  //                       '',
  //                   value: 'value'),
  //               _buildListDetail(
  //                   title: AppLocalizations.of(context)
  //                           ?.kBillBoardAdvertisingChargeLabel ??
  //                       '',
  //                   value: 'value'),
  //               Text(
  //                 kElectricFeeLabel,
  //                 style: TextStyle(
  //                     fontFamily: AppData.shared.fontFamily2,
  //                     fontSize: kTextRegular3x,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //               1.vGap
  //             ],
  //           ),
  //         ),
  //         ListView.builder(
  //             itemCount: 2,
  //             shrinkWrap: true,
  //             padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
  //             physics: NeverScrollableScrollPhysics(),
  //             itemBuilder: (context, index) {
  //               return Column(
  //                 spacing: kMargin12,
  //                 children: [
  //                   _buildMonthyInvoiceChild(context),
  //                   Divider(),
  //                   1.vGap
  //                 ],
  //               );
  //             }),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildMonthyInvoiceChild(context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         spacing: kMargin12,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             kYesbLabel,
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w700, fontSize: kTextRegular),
  //           ),
  //           Text(
  //             AppLocalizations.of(context)?.kPreviousMonthLabel ?? '',
  //             style: TextStyle(fontSize: kTextRegular),
  //           ),
  //           Text(
  //             AppLocalizations.of(context)?.kThisMonthLabel ?? '',
  //             style: TextStyle(fontSize: kTextRegular),
  //           )
  //         ],
  //       ),
  //       Column(
  //         spacing: kMargin12,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(
  //             AppLocalizations.of(context)?.kUnitLabel ?? '',
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w700, fontSize: kTextRegular),
  //           ),
  //           Text(
  //             '10',
  //             style: TextStyle(fontSize: kTextRegular),
  //           ),
  //           Text(
  //             '6',
  //             style: TextStyle(fontSize: kTextRegular),
  //           )
  //         ],
  //       ),
  //       Column(
  //         spacing: kMargin12,
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: [
  //           Text(
  //             AppLocalizations.of(context)?.kRateLabel ?? '',
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w700, fontSize: kTextRegular),
  //           ),
  //           Text(
  //             '50000 MMK'.replaceRange(2, 2, ','),
  //             style: TextStyle(fontSize: kTextRegular),
  //           ),
  //           Text(
  //             '',
  //             style: TextStyle(fontSize: kTextRegular),
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
