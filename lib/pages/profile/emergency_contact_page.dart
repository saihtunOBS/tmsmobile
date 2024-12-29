import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../utils/images.dart';
import '../../utils/strings.dart';

class EmergencyContactPage extends StatelessWidget {
  EmergencyContactPage({super.key});

  final List<String> contacts = [
    kPropertyManagementLabel,
    kPoliceStationLabel,
    kFireStationLabel,
    kEpcLabel,
    kCustomerServiceLabel
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              kBillingBackgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: kMarginMedium2,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.16,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: kMarginMedium2,
                      right: kMarginMedium2,
                      bottom: kMarginMedium2),
                  child: Column(
                    children: contacts.asMap().entries.map((entry) {
                      return _buildListItem(title: entry.value);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          ///appbar
          Positioned(top: 0, child: ProfileAppbar()),
        ],
      ),
    );
  }

  Widget _listItem(
      {required String title, required String value, bool? isNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMargin5,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        Text(
          value,
          style: TextStyle(
              color: isNumber == true ? kBlueColor : kBlackColor,
              fontSize: kTextRegular18,
              fontWeight: FontWeight.w700,
              decoration: isNumber == true ? TextDecoration.underline : null,
              decorationColor: kBlueColor,
              decorationThickness: 3.0),
        ),
      ],
    );
  }

  Widget _buildListItem({String? title}) {
    return Container(
      margin: EdgeInsets.only(bottom: kMargin10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
          title: Text(
            title ?? '',
            style: TextStyle(
                color: kWhiteColor,
                fontSize: kTextRegular2x,
                fontWeight: FontWeight.w700),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: kMargin10, horizontal: kMargin10),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: kMargin12,
                children: [
                  _listItem(title: kContactNameLabel, value: 'YESC'),
                  _listItem(title: kAddressLabel, value: 'Yangon'),
                  _listItem(
                      title: kTelephoneNormalLabel,
                      value: '098888888',
                      isNumber: true),
                  _listItem(
                      title: kTelephoneNormal24Label,
                      value: '096666666',
                      isNumber: true),
                  _listItem(title: kContractRefLabel, value: '-'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
