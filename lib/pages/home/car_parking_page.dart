import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';

import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../widgets/appbar.dart';

class CarParkingPage extends StatelessWidget {
  const CarParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(kCarParkingLabel)),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                kBillingBackgroundImage,
                fit: BoxFit.fill,
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.symmetric(
                    vertical: kMarginMedium2, horizontal: kMarginMedium2 + 2),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildBody();
                })
          ],
        ));
  }

  Widget _listItem(
      {required String title, required String value, bool? isStatus}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        isStatus == true
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kMargin6, vertical: kMargin6),
                decoration: BoxDecoration(
                    color: kRedColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(kMarginMedium2)),
                child: Center(
                  child: FittedBox(
                      child: Text(
                    'Unavailable',
                    style: TextStyle(color: kRedColor, fontSize: kTextSmall),
                  )),
                ),
              )
            : Text(
                value,
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w700),
              ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(bottom: kMarginMedium2),
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
                kParkingCodeLabel,
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
                  _listItem(title: kParkingCodeLabel, value: 'value'),
                  _listItem(
                      title: kStatusLabel, value: 'value', isStatus: true),
                  _listItem(title: kVehicleNoLabel, value: 'value'),
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
