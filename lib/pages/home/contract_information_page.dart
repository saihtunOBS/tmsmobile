import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';

import '../../utils/strings.dart';
import '../../widgets/appbar.dart';

class ContractInformationPage extends StatelessWidget {
  const ContractInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(kContractInformationLabel)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    vertical: kMarginMedium2, horizontal: kMarginMedium2 + 2),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildBody();
                })
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin:
          EdgeInsets.only(left: kMargin24, right: kMargin24, top: kMargin24),
      child: Column(
        spacing: kMarginMedium14,
        children: [
          _listItem(title: kCreatedDateLabel, value: 'value'),
          _listItem(title: kTenantTypeLabel, value: 'value'),
          _listItem(title: kTenantCategoryLabel, value: 'value'),
          _listItem(title: kStartDateLabel, value: 'value'),
          _listItem(title: kEndDateLabel, value: 'value'),
          Divider(
            thickness: 0.5,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget _listItem({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        Text(
          value,
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(bottom: kMarginMedium2 + 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMargin10),
        boxShadow: [
          BoxShadow(
              offset: Offset(
                0,
                4,
              ),
              blurRadius: 10,
              color: const Color.fromARGB(255, 207, 205, 205))
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMarginSmallx),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMargin10),
          gradient: LinearGradient(
            colors: [kPrimaryColor, kThirdColor],
            stops: [0.0, 1.0],
          ),
        ),
        child: ExpansionTile(
          showTrailingIcon: false,
          shape: Border(),
          collapsedShape: Border(),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kRoomShopNameLabel,
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: kTextRegular13,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                '#CC1',
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: kTextRegular2x,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: kMargin10, horizontal: kMargin10),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                spacing: kMargin10,
                children: [
                  _listItem(title: kBranchLabel, value: 'value'),
                  _listItem(title: kBuildingLabel, value: 'value'),
                  _listItem(title: kFloorLabel, value: 'value'),
                  _listItem(title: kZoneViewLabel, value: 'value'),
                  _listItem(title: kRoomTypeLabel, value: 'value'),
                  _listItem(title: kRoomShopNameLabel, value: 'value'),
                  _listItem(title: kTotalAreaLabel, value: 'value'),
                   5.vGap,
                  _buildParkingInformation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingInformation() {
    return ListTileTheme(
      dense: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMargin5),
          gradient: LinearGradient(
            colors: [kPrimaryColor, kThirdColor],
            stops: [0.0, 1.0],
          ),
        ),
        child: ExpansionTile(
          shape: Border(),
          collapsedShape: Border(),
          iconColor: kWhiteColor,
          collapsedIconColor: kWhiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: kMargin10,
            children: [
              Icon(
                CupertinoIcons.car_detailed,
                color: kWhiteColor,
              ),
              Text(
                kParkingInformationLabel,
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: kTextRegular2x,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: kMargin10),
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
              child: Column(
                spacing: kMargin10,
                children: [
                  _listItem(title: kBranchLabel, value: 'value'),
                  _listItem(title: kBuildingLabel, value: 'value'),
                  _listItem(title: kFloorLabel, value: 'value'),
                  _listItem(title: kZoneViewLabel, value: 'value'),
                  _listItem(title: kRoomTypeLabel, value: 'value'),
                  _listItem(title: kRoomShopNameLabel, value: 'value'),
                  _listItem(title: kTotalAreaLabel, value: 'value'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
