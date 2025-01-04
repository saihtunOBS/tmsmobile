import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/mm_nrc_kit.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/house_hold_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../data/app_data/app_data.dart';
import '../../data/vos/resident_vo.dart';
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
  int? selected;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HouseHoldBloc(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            image: DecorationImage(
                image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
        child: Consumer<HouseHoldBloc>(
          builder: (context, value, child) => Scaffold(
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
                        child: _buildHouseHoldRegistration(context),
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



  /// already registration view
  Widget _buildHouseHoldRegistration(BuildContext context) {
    return Column(
      children: [
        _listItem(title: kRegistrationDateLabel, value: '12 Dec, 2023'),
        10.vGap,
        _listItem(title: kMoveInDateLabel, value: '12 Dec, 2023'),
        kSize18.vGap,
        Container(
          decoration: BoxDecoration(
            color: kWhiteColor,
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Container(
                            color: kInputBackgroundColor,
                            padding: EdgeInsets.only(bottom: kMargin10),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                spacing: kMarginMedium2,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: titles.asMap().entries.map((entry) {
                                  return Container(
                                    padding: EdgeInsets.only(left: kMargin12),
                                    width: MediaQuery.of(context).size.width /
                                        2.15,
                                    height: entry.key == 0 ? kSize43 : null,
                                    decoration: BoxDecoration(
                                      color: entry.key == 0
                                          ? kDarkBlueColor
                                          : null,
                                    ),
                                    child: Text(
                                      entry.value,
                                      style: TextStyle(
                                          color: entry.key == 0
                                              ? Colors.transparent
                                              : Colors.black,
                                          fontWeight: entry.key == 0
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                          fontSize: kTextRegular),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: kMargin10),
                            color: kThirdGrayColor,
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    titles.asMap().entries.map((parentEntry) {
                                  return Column(
                                    spacing: kMarginMedium2,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children:
                                        titles.asMap().entries.map((entry) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.15,
                                        height: entry.key == 0 ? kSize43 : null,
                                        decoration: BoxDecoration(
                                          color: entry.key == 0
                                              ? kDarkBlueColor
                                              : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            entry.value,
                                            style: TextStyle(
                                                decoration: parentEntry.key != 0
                                                    ? entry.key == 1
                                                        ? TextDecoration
                                                            .underline
                                                        : TextDecoration.none
                                                    : TextDecoration.none,
                                                decorationThickness: 2.0,
                                                color: entry.key == 0
                                                    ? kWhiteColor
                                                    : Colors.black,
                                                fontWeight: entry.key == 0
                                                    ? FontWeight.w700
                                                    : FontWeight.normal,
                                                fontSize: kTextRegular),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }).toList(),
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

  //add new registration view
  Widget _buildRegistrationForm() {
    return Column(
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
        _buildDatePicker(kRegistrationDateLabel, 'Dec 25,2024'),
        _buildDatePicker(kMoveInDateLabel, 'Dec 22,2024'),
        _buildOwnerInformation(),
        _buildResidentInformation(context),
        kSize70.vGap
      ],
    );
  }

  ///resident list view
  Widget _buildResidentField(
      {required ResidentVo? residentData, required int index}) {
    return Consumer<HouseHoldBloc>(
      builder: (context, bloc, child) => ListTileTheme(
        dense: true,
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(kMargin10),
                  bottomRight: Radius.circular(kMargin10))),
          child: ExpansionTile(
            key: Key(bloc.selectedExpensionIndex.toString()),
            initiallyExpanded: bloc.selectedExpensionIndex == index,
            onExpansionChanged: (isExpanded) {
              if (isExpanded) {
                bloc.selectedExpensionIndex = index;
              } else {
                bloc.selectedExpensionIndex = -1;
              }
              bloc.changeExpansion();
            },
            collapsedIconColor: kWhiteColor,
            iconColor: kWhiteColor,
            shape: Border(),
            title: Text(residentData?.name ?? '',
                style: TextStyle(
                    fontFamily: AppData.shared.fontFamily2,
                    fontSize: kTextRegular3x,
                    color: kWhiteColor,
                    fontWeight: FontWeight.w600)),
            children: [
              Container(
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(kMargin10),
                        bottomRight: Radius.circular(kMargin10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kMargin10),
                  child: Column(
                    spacing: kMarginMedium2,
                    children: [
                      1.vGap,
                      _buildInputField(
                          title: kNameLabel,
                          isReadOnly: true,
                          value: residentData?.name),
                      _buildInputField(
                          title: kGenderLabel,
                          isReadOnly: true,
                          value: residentData?.data.gender),
                      _buildInputField(
                          title: kDobLabel,
                          isReadOnly: true,
                          value: residentData?.data.dob),
                      _buildInputField(
                          title: kRaceLabel,
                          isReadOnly: true,
                          value: residentData?.data.race),
                      _buildInputField(
                          title: kNationalityLabel,
                          isReadOnly: true,
                          value: residentData?.data.nationality),
                      _buildInputField(
                          title: kNRCLabel,
                          isReadOnly: true,
                          value: residentData?.data.nrc),
                      _buildInputField(
                          title: kContactNumberLabel,
                          isReadOnly: true,
                          value: residentData?.data.contactNumber),
                      _buildInputField(
                          title: kRelatedToOwnerLabel,
                          isReadOnly: true,
                          value: residentData?.data.relatedTo),

                      ///delete button
                      Consumer<HouseHoldBloc>(
                        builder: (_, bloc, child) => Row(children: [
                          Spacer(),
                          IconButton(
                              onPressed: () =>
                                  bloc.removeResident(index: index),
                              icon: Image.asset(
                                kDeleteIcon,
                                width: kSize28,
                                height: kSize28,
                                color: kBlackColor,
                              ))
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //date picker
  Widget _buildDatePicker(String title, String value) {
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
              color: kGreyColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(kMarginMedium)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
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


  //genre
  List<String> genders = ['Male', 'Female'];
  Widget _buildGenderDropDown({bool? isEditDeleteForm}) {
    return Consumer<HouseHoldBloc>(
      builder: (_, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kGenderLabel,
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
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
                value: bloc.gender,
                isExpanded: true,
                underline: Container(),
                hint: Text(kSelectGenderLabel),
                items: genders.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: ((value) {
                  bloc.gender = value;
                  bloc.onSelectGender();
                })),
          )
        ],
      ),
    );
  }

  /// dob picker
  Widget _buildDateOfBirthDatePicker({String? value}) {
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
              color: kGreyColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(kMarginMedium)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value ?? kSelectDateLabel,
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

  //input field
  Widget _buildInputField(
      {required title,
      String? value,
      bool? isReadOnly,
      TextEditingController? controller}) {
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
                color: kGreyColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: isReadOnly == true
                ? Padding(
                    padding: const EdgeInsets.only(top: kMargin12),
                    child: Text(value ?? ''),
                  )
                : TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: title),
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

  ///resident information
  Widget _buildResidentInformation(BuildContext context) {
    return Consumer<HouseHoldBloc>(
      builder: (_, bloc, child) => Container(
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
              child: Consumer<HouseHoldBloc>(
                builder: (_, bloc, child) => Column(
                  spacing: kMarginMedium2,
                  children: [
                    1.vGap,
                    _buildInputField(
                        title: kNameLabel,
                        controller: bloc.residentNameController),
                    _buildGenderDropDown(),
                    InkWell(
                        onTap: () => bloc.showDate(),
                        child: _buildDateOfBirthDatePicker(
                            value:
                                DateFormatter.formatDate(bloc.selectedDate))),
                    _buildInputField(
                        title: kRaceLabel,
                        controller: bloc.residentRaceController),
                    _buildInputField(
                        title: kNationalityLabel,
                        controller: bloc.residentNationalityController),
                    _buildNRCPickerView(),
                    _buildInputField(
                        title: kContactNumberLabel,
                        controller: bloc.residentContactController),
                    _buildInputField(
                        title: kRelatedToOwnerLabel,
                        controller: bloc.residentRelatedToController),

                    /// add resident button
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            var residentVo = ResidentVo(
                                bloc.residentNameController.text.trim(),
                                ResidentDataVo(
                                    name: bloc.residentContactController.text
                                        .trim(),
                                    race:
                                        bloc.residentRaceController.text.trim(),
                                    nationality: bloc
                                        .residentNationalityController.text
                                        .trim(),
                                    contactNumber: bloc
                                        .residentContactController.text
                                        .trim(),
                                    relatedTo: bloc
                                        .residentRelatedToController.text
                                        .trim(),
                                    gender: bloc.gender,
                                    dob: DateFormatter.formatDate(
                                        bloc.selectedDate),
                                    nrc: bloc.nrc));
                            bloc.addResident(resident: residentVo);
                          },
                          child: Container(
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
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            20.vGap,
            Consumer<HouseHoldBloc>(
                builder: (context, bloc, child) => Column(
                      spacing: kMargin10,
                      children: bloc.residentVo.asMap().entries.map((data) {
                        return _buildResidentField(
                            residentData: data.value, index: data.key);
                      }).toList(),
                    )),
          ],
        ),
      ),
    );
  }

  ///nrc picker
  Widget _buildNRCPickerView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        kNRCLabel,
        style: TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
      ),
      4.vGap,
      Consumer<HouseHoldBloc>(
        builder: (context, bloc, child) => Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(kMarginMedium)),
          child: NRCField(
            backgroundColor: Colors.transparent,
            language: NrcLanguage.english,
            pickerItemColor: Colors.black,
            leadingTitleColor: Colors.black54,
            onCompleted: (value) {
              debugPrint('complete.....$value');
              bloc.nrc = value;
              bloc.onChangeNRC();
            },
            onChanged: (value) {},
          ),
        ),
      ),
    ]);
  }
}
