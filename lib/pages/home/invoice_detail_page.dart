import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';

class InvoiceDetailPage extends StatelessWidget {
  const InvoiceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            kInvoiceDetailLabel,
            action: _buildDownloadButton(),
          )),
      body: _buildBody(),
      bottomNavigationBar: Container(
        height: kBottomBarHeight,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(offset: Offset(8, 0), blurRadius: 10, color: kGreyColor)
          ]),
          child: Center(child: gradientButton(title: kMakePaymentLabel, onPress: () {}))),
    );
  }

  Widget _buildDownloadButton() {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.download,
          color: kWhiteColor,
        ));
  }

  Widget _buildBody() {
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
                _buildListDetail(title: kInvoiceNoLabel, value: 'value'),
                _buildListDetail(title: kDateLabel, value: 'value'),
                _buildListDetail(title: kTenantNameLabel, value: 'value'),
                _buildListDetail(title: kRoomShopNameLabel, value: 'value'),
                _buildListDetail(title: kPhoneNumberLabel, value: 'value'),
                _buildListDetail(title: kMonthLabel, value: 'value'),
                _buildListDetail(title: kDueDateLabel, value: 'value'),
              ],
            ),
          ),
          1.vGap,
          _buildMaintenanceInvoice(),
          _buildMonthyInvoice(),
          _buildPrice(),
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

  Widget _buildMaintenanceInvoice() {
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
              padding: EdgeInsets.only(left: kTextRegular2x, top: kMargin10),
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
                kMaintenanceInvoiceLabel,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: kTextRegular2x,
                    color: kWhiteColor),
              )),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: kTextRegular2x, vertical: kMargin10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildMaintenanceInvoiceChild(),
                    index == 1 ? SizedBox.shrink() : Divider()
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildMaintenanceInvoiceChild() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMargin10),
      child: Column(
        spacing: kMargin12,
        children: [
          _buildListDetail(
              title: kDetailLabel,
              value:
                  'this is description this is descriptionthis is descriptionthis is descriptionthis is descriptionthis is descriptionthis is descriptionthis is description'),
          _buildListDetail(title: kUnitLabel, value: 'value'),
          _buildListDetail(title: kQtyLabel, value: 'value'),
          _buildListDetail(title: kTaxPercentLabel, value: 'value'),
          _buildListDetail(title: kRateLabel, value: 'value'),
          _buildListDetail(title: kAmountLabel, value: 'value'),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
      padding:
          EdgeInsets.symmetric(horizontal: kTextRegular2x, vertical: kMargin10),
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
          _buildListDetail(title: kSubTotal, value: 'value'),
          _buildListDetail(title: kTaxLabel, value: 'value'),
          _buildListDetail(title: kLateFeeLabel, value: 'value'),
          _buildListDetail(title: kGrandTotalLabel, value: 'value'),
        ],
      ),
    );
  }

  Widget _buildMonthyInvoice() {
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
              padding: EdgeInsets.only(left: kTextRegular2x, top: kMargin10),
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
                kMonthlyInvoiceLabel,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: kTextRegular2x,
                    color: kWhiteColor),
              )),
          Container(
            margin: EdgeInsets.only(
                left: kTextRegular2x, right: kTextRegular2x, top: kMargin10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: kMargin12,
              children: [
                _buildListDetail(title: kRentalFeeLabel, value: 'value'),
                _buildListDetail(title: kCommercialTaxLabel, value: 'value'),
                _buildListDetail(title: kAdvertisingFeeLabel, value: 'value'),
                _buildListDetail(
                    title: kCleanAndSecurityFeeLabel, value: 'value'),
                _buildListDetail(
                    title: kAirconAndElevatorFeeLabel, value: 'value'),
                _buildListDetail(
                    title: kPetAndMosquitoControlLabel, value: 'value'),
                _buildListDetail(
                    title: kBillBoardAdvertisingChargeLabel, value: 'value'),
                Text(
                  kElectricFeeLabel,
                  style: TextStyle(
                          fontFamily: AppData.shared.fontFamily2,
                      fontSize: kTextRegular3x, fontWeight: FontWeight.w600),
                
                ),
                1.vGap
              ],
            ),
          ),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: kTextRegular2x),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  spacing: kMargin12,
                  children: [_buildMonthyInvoiceChild(), Divider(), 1.vGap],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildMonthyInvoiceChild() {
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
