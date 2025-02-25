// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/maintenance_quotation_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/process_vo.dart';
import 'package:tmsmobile/data/vos/quotation_vo.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/number_extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaintenanceQuotationPage extends StatelessWidget {
  const MaintenanceQuotationPage(
      {super.key,
      required this.quotation,
      required this.id,
      required this.data});
  final QuotationVO quotation;
  final String id;
  final ServiceRequestVo data;

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
            _buildBody(context, quotation, data),

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
          GestureDetector(
            onTap: () => bloc.changeStatus(true).then((_) {
              Navigator.pop(context, true);
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
          GestureDetector(
            onTap: () => bloc.changeStatus(false).then((_) {
              Navigator.pop(context, true);
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

  Widget _buildBody(
      BuildContext context, QuotationVO quotationData, ServiceRequestVo data) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kMarginMedium2, vertical: kMarginMedium2),
            child: Column(
              spacing: kMargin12,
              children: [
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kInvoiceNoLabel ?? '',
                    value: data.id ?? ''),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kDateLabel ?? '',
                    value: DateFormatter.formatStringDate(
                        quotationData.date ?? '')),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kTenantNameLabel ?? '',
                    value: quotationData.tenant ?? ''),
                _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                    value: quotationData.shop ?? ''),
                _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kPhoneNumberLabel ?? '',
                    value: PersistenceData.shared.getUser()?.phoneNumber ?? ''),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kMonthLabel ?? '',
                    value: '-'),
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kDueDateLabel ?? '',
                    value: '-'),
              ],
            ),
          ),
          data.processData?.isEmpty ?? true
              ? SizedBox()
              : _buildMaintenanceInvoice(
                  context, data.processData?.first ?? ProcessVO()),
          15.vGap,
          // //_buildMonthyInvoice(context),
          data.processData?.isEmpty ?? true
              ? SizedBox()
              : _buildPrice(context, data.processData?.first ?? ProcessVO()),
          20.vGap
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

  Widget _buildMaintenanceInvoice(context, ProcessVO data) {
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
              itemCount: data.details?.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: kMarginMedium2, vertical: kMargin10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildMaintenanceInvoiceChild(
                        context, data.details?[index] ?? DetailVO()),
                    index == 1 ? SizedBox.shrink() : Divider()
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildMaintenanceInvoiceChild(context, DetailVO data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMargin10),
      child: Column(
        spacing: kMargin12,
        children: [
          _buildListDetail(
              title: AppLocalizations.of(context)?.kDetailLabel ?? '',
              value: data.description ?? ''),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kUnitLabel ?? '',
              value: '-'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kQtyLabel ?? '',
              value: data.qty.toString()),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kTaxPercentLabel ?? '',
              value: '${data.tax}%'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kRateLabel ?? '',
              value: '${data.price?.toInt().toString().format} MMK'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kAmountLabel ?? '',
              value: '${data.amount?.toInt().toString().format} MMK'),
        ],
      ),
    );
  }

  Widget _buildPrice(context, ProcessVO data) {
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
              value: '${data.subTotal?.toInt().toString().format ?? 0} MMK'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kTaxLabel ?? '', value: '-'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kLateFeeLabel ?? '',
              value: '-'),
          _buildListDetail(
              title: AppLocalizations.of(context)?.kGrandTotalLabel ?? '',
              value: '${data.grandTotal?.toInt().toString().format ?? 0} MMK'),
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
  //                     fontSize: kTextRegular,
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
