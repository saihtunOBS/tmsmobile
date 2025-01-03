import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/mm_nrc_kit.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/house_hold_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../widgets/gradient_button.dart';

class HouseholdRegistrationPage extends StatefulWidget {
  const HouseholdRegistrationPage({super.key});

  @override
  State<HouseholdRegistrationPage> createState() =>
      _HouseholdRegistrationPageState();
}

class _HouseholdRegistrationPageState extends State<HouseholdRegistrationPage> {
  final List<String> titles = [
    'Owner',
    kNameLabel,
    kGenderLabel,
    kDobLabel,
    kRaceLabel,
    kNationalityLabel,
    kNRCLabel,
    kContactNameLabel,
    kEmailAddressLabel,
    kRelatedToOwnerLabel
  ];
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HouseHoldBloc(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            image: DecorationImage(
                image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
        child: Consumer<HouseHoldBloc>(
          builder: (context, value, child) => 
           Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            resizeToAvoidBottomInset: true,
            body: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: kMarginMedium2,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.14,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: kMarginMedium2,
                            right: kMarginMedium2,
                            bottom: kMarginMedium2),
                        child: _buildRegistrationForm(),
                      ),
                    ],
                  ),
                ),
                
                ///appbar
                Positioned(
                    top: 0,
                    child: ProfileAppbar(
                      title: kHouseholdLabel,
                    )),
              ],
            ),
            bottomNavigationBar: Container(
                color: kWhiteColor,
                height: kBottomBarHeight,
                child: Center(
                  child: gradientButton(title: kSubmitLabel, onPress: () {}),
                )),
          ),
        ),
      ),
    );
  }

  Widget _listItem({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: kMargin5,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        Text(
          value,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: kTextRegular2x,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessRegistrationForm(BuildContext context) {
    return Column(
      children: [
        _listItem(title: kRegistrationDateLabel, value: '12 Dec, 2023'),
        10.vGap,
        _listItem(title: kMoveInDateLabel, value: '12 Dec, 2023'),
        kSize18.vGap,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhiteColor,
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Container(
                            height: kSize43,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kDarkBlueColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(kMarginMedium),
                                )),
                          ),
                          kMarginMedium2.vGap,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kMargin24, vertical: kMargin10 + 1),
                            child: Column(
                              spacing: kMarginMedium2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: titles.asMap().entries.map((entry) {
                                return Text(
                                  entry.value,
                                  style: TextStyle(
                                      color: entry.key == 0
                                          ? kDarkBlueColor
                                          : Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: kTextRegular),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          kMarginMedium2.vGap,
                          Container(
                            color: kThirdGrayColor,
                            height: kSize366,
                          ),
                          Container(
                            height: kSize43,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kDarkBlueColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(kMarginMedium),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: kMargin10 + 1, bottom: kMargin10 + 1),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  (MediaQuery.of(context).size.width * 0.09)
                                      .hGap,
                                  Column(
                                    spacing: kMarginMedium2,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children:
                                        titles.asMap().entries.map((entry) {
                                      return Text(
                                        entry.value,
                                        style: TextStyle(
                                            color: entry.key == 0
                                                ? kWhiteColor
                                                : Colors.black,
                                            fontWeight: entry.key == 0
                                                ? FontWeight.w700
                                                : FontWeight.normal,
                                            fontSize: kTextRegular),
                                      );
                                    }).toList(),
                                  ),
                                  kSize40.hGap,
                                  Column(
                                    spacing: kMarginMedium2,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children:
                                        titles.asMap().entries.map((entry) {
                                      return Text(
                                        entry.value,
                                        style: TextStyle(
                                            color: entry.key == 0
                                                ? kWhiteColor
                                                : Colors.black,
                                            fontWeight: entry.key == 0
                                                ? FontWeight.w700
                                                : FontWeight.normal,
                                            fontSize: kTextRegular),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kMarginMedium2,
        children: [
          Text(
            kHouseholdLabel,
            style: TextStyle(
                fontFamily: AppData.shared.fontFamily2,
                fontWeight: FontWeight.w600,
                fontSize: kTextRegular24),
          ),
          _buildRegistrationDatePicker(),
          _buildMoveInDatePicker(),
          _buildOwnerInformation(),
          _buildResidentInformation(),
          _buildEditDeleteForm(),
          kSize70.vGap
        ],
      ),
    );
  }

  Widget _buildRegistrationDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kRegistrationDateLabel,
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
        ),
        4.vGap,
        Container(
          height: kMargin45 + 1,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
          decoration: BoxDecoration(
              color: kGreyColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(kMarginMedium)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Dec 25,2024',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: kTextRegular2x),
              ),
              Icon(
                Icons.calendar_today,
                size: 22.0,
              )
            ],
          ),
        )
      ],
    );
  }

  List<String> genders = ['Male', 'Female'];
  Widget _buildGenderDropDown({bool? isEditDeleteForm}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kGenderLabel,
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
        ),
        4.vGap,
        Container(
          padding: EdgeInsets.symmetric(horizontal: kMargin10),
          decoration: BoxDecoration(
              color: isEditDeleteForm == true
                  ? kWhiteColor
                  : kInputBackgroundColor,
              borderRadius: BorderRadius.circular(kMarginMedium)),
          child: DropdownButton(
              value: _selectedGender,
              isExpanded: true,
              underline: Container(),
              hint: Text(kSelectGenderLabel),
              items: genders.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: ((value) {
                setState(() {
                  _selectedGender = value ?? '';
                });
              })),
        )
      ],
    );
  }

  Widget _buildMoveInDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kMoveInDateLabel,
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
        ),
        4.vGap,
        Container(
          height: kMargin45 + 1,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
          decoration: BoxDecoration(
              color: kGreyColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(kMarginMedium)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Dec 25,2024',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: kTextRegular2x),
              ),
              Icon(
                Icons.calendar_today,
                size: 22.0,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDateOfBirthDatePicker({bool? isEditDeleteForm}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kDobLabel,
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
        ),
        4.vGap,
        Container(
          height: kMargin45 + 1,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
          decoration: BoxDecoration(
              color: isEditDeleteForm == true
                  ? kWhiteColor
                  : kGreyColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(kMarginMedium)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                kSelectDateLabel,
                style: TextStyle(fontSize: kTextRegular2x),
              ),
              Icon(
                Icons.calendar_today,
                size: 22.0,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildInputField(
      {required title, bool? isEditDeleteForm, bool? isNRC}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
        ),
        4.vGap,
        Container(
            height: kMargin45 + 1,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
            decoration: BoxDecoration(
                color: isEditDeleteForm == true
                    ? kWhiteColor
                    : kGreyColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: TextField(
              onTap: () => isNRC == true
                  ? showDialog(
                      context: context,
                      builder: (_) => Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: kMarginMedium2),
                            backgroundColor: kBackgroundColor,
                            child: _buildNRCPickerView(context),
                          ))
                  : null,
              readOnly: isNRC ?? false,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: title),
            ))
      ],
    );
  }

  ///ower information
  Widget _buildOwnerInformation() {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(kMargin10),
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
              padding: EdgeInsets.only(left: kTextRegular2x, top: kMargin5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kMargin10),
                    topRight: Radius.circular(kMargin10)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Text(kOwnerInformationLabel,
                  style: TextStyle(
                      fontFamily: AppData.shared.fontFamily2,
                      fontSize: kTextRegular24,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMargin10),
            child: Column(
              spacing: kMarginMedium2,
              children: [
                1.vGap,
                _buildInputField(title: kOwnerNameLabel),
                _buildGenderDropDown(),
                _buildDateOfBirthDatePicker(),
                _buildInputField(title: kRaceLabel),
                _buildInputField(title: kNationalityLabel),
                _buildInputField(title: kContactNumberLabel),
                _buildInputField(title: kEmailAddressLabel),
                1.vGap
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResidentInformation() {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(kMargin10),
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
              padding: EdgeInsets.only(left: kTextRegular2x, top: kMargin5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kMargin10),
                    topRight: Radius.circular(kMargin10)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Text(kResidentDataLabel,
                  style: TextStyle(
                      fontFamily: AppData.shared.fontFamily2,
                      fontSize: kTextRegular24,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMargin10),
            child: Column(
              spacing: kMarginMedium2,
              children: [
                1.vGap,
                _buildInputField(title: kNameLabel),
                _buildGenderDropDown(),
                _buildDateOfBirthDatePicker(),
                _buildInputField(title: kRaceLabel),
                _buildInputField(title: kNationalityLabel),
                _buildInputField(
                  title: kNRCLabel,
                  isNRC: true,
                ),
                _buildInputField(title: kContactNumberLabel),
                _buildInputField(title: kRelatedToOwnerLabel),

                /// add resident button
                Row(
                  children: [
                    Spacer(),
                    Container(
                      height: kSize33,
                      padding: EdgeInsets.only(
                          top: kMargin5,
                          left: kMargin5 + 2,
                          right: kMargin5 + 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            kMargin10,
                          ),
                          border: Border.all(color: kPrimaryColor)),
                      child: Text(
                        kAddResidentLabel,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: kPrimaryColor),
                      ),
                    )
                  ],
                ),
                1.vGap
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNRCPickerView(context) {
    return Container(
      height: null,
      decoration: BoxDecoration(color: kBackgroundColor),
      margin: EdgeInsets.symmetric(vertical: kMargin24),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            NRCField(
              language: NrcLanguage.english,
              pickerItemColor: kPrimaryColor,
              leadingTitleColor: kPrimaryColor,
              onCompleted: (value) {},
              onChanged: (value) {
                debugPrint("onChanged : $value");
              },
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: kSize45,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    colors: [kPrimaryColor, kThirdColor],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: kWhiteColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditDeleteForm() {
    return Container(
      decoration: BoxDecoration(
        color: kSkyBlueColor,
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
              height: 5,
              width: double.infinity,
              padding: EdgeInsets.only(left: kTextRegular2x, top: kMargin5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kMargin10),
                    topRight: Radius.circular(kMargin10)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Text(kResidentDataLabel,
                  style: TextStyle(
                      fontFamily: AppData.shared.fontFamily2,
                      fontSize: kTextRegular24,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMargin10),
            child: Column(
              spacing: kMarginMedium2,
              children: [
                1.vGap,
                _buildInputField(title: kNameLabel, isEditDeleteForm: true),
                _buildGenderDropDown(isEditDeleteForm: true),
                _buildDateOfBirthDatePicker(isEditDeleteForm: true),
                _buildInputField(title: kRaceLabel, isEditDeleteForm: true),
                _buildInputField(
                    title: kNationalityLabel, isEditDeleteForm: true),
                _buildInputField(title: kNRCLabel, isEditDeleteForm: true),
                _buildInputField(
                    title: kContactNumberLabel, isEditDeleteForm: true),
                _buildInputField(
                    title: kRelatedToOwnerLabel, isEditDeleteForm: true),
                1.vGap
              ],
            ),
          ),
          Container(
              height: 5,
              width: double.infinity,
              padding: EdgeInsets.only(left: kTextRegular2x, top: kMargin5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kMargin10),
                    bottomRight: Radius.circular(kMargin10)),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Text(kResidentDataLabel,
                  style: TextStyle(
                      fontFamily: AppData.shared.fontFamily2,
                      fontSize: kTextRegular24,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
