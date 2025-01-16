import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/house_hold_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/resident_list_item.dart';
import 'package:tmsmobile/network/requests/household_registration_request.dart';
import 'package:tmsmobile/pages/profile/add_resident_page.dart';
import 'package:tmsmobile/pages/profile/edit_resident_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/common_dialog.dart';
import 'package:tmsmobile/widgets/empty_houldhold.dart';
import 'package:tmsmobile/widgets/error_dialog_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import 'package:tmsmobile/widgets/nrc_view.dart';
import 'package:tmsmobile/widgets/owner_nrc_view.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';
import '../../widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HouseholdRegistrationPage extends StatefulWidget {
  const HouseholdRegistrationPage({super.key});

  @override
  State<HouseholdRegistrationPage> createState() =>
      _HouseholdRegistrationPageState();
}

class _HouseholdRegistrationPageState extends State<HouseholdRegistrationPage> {
  int? selected;
  bool? isClickRegistrationForm = false;
  String _selectedOption = "Citizen";
  String _selectedOwnerNRC = 'Citizen';
  String? ownerGender;
  String? residentGender;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HouseHoldBloc(context: context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            image: DecorationImage(
                image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
        child: Consumer<HouseHoldBloc>(
          builder: (context, bloc, child) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            resizeToAvoidBottomInset: true,
            body: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                bloc.isLoading
                    ? Center(
                        child: LoadingView(
                            indicator: Indicator.ballBeat,
                            indicatorColor: kPrimaryColor),
                      )
                    : SingleChildScrollView(
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
                                child: bloc.householdList.isEmpty
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.16),
                                            child: Visibility(
                                              visible:
                                                  isClickRegistrationForm ==
                                                      false,
                                              child:
                                                  EmptyHousehold(onPress: () {
                                                setState(() {
                                                  isClickRegistrationForm =
                                                      true;
                                                });
                                              }),
                                            ),
                                          ),
                                          Visibility(
                                              visible:
                                                  isClickRegistrationForm ??
                                                      false,
                                              maintainAnimation: true,
                                              maintainState: true,
                                              child: AnimatedOpacity(
                                                  duration: Duration(
                                                      milliseconds: 400),
                                                  opacity:
                                                      isClickRegistrationForm ==
                                                              false
                                                          ? 0
                                                          : 1,
                                                  child:
                                                      _buildRegistrationForm())),

                                          //loading
                                          if (bloc.isSubmitLoading == true)
                                            LoadingView(
                                                indicator: Indicator.ballBeat,
                                                indicatorColor: kPrimaryColor),
                                        ],
                                      )
                                    : _buildHouseHoldRegistration(
                                        context,
                                        DateFormatter.formatDate(bloc
                                            .householdList.first.registerDate),
                                        DateFormatter.formatDate(bloc
                                            .householdList.first.moveInDate),
                                        bloc.householdList.first
                                            .emergencyContactNumber,
                                        bloc.householdList.first.information,
                                        bloc)),
                          ],
                        ),
                      ),

                ///appbar
                Positioned(
                    top: 0,
                    child: ProfileAppbar(
                      title: AppLocalizations.of(context)?.kHouseholdLabel,
                    )),
              ],
            ),
            bottomNavigationBar: Consumer<HouseHoldBloc>(
              builder: (context, bloc, child) => bloc.isLoading
                  ? SizedBox()
                  : bloc.householdList.isNotEmpty
                      ? SizedBox.shrink()
                      : Container(
                          color: kWhiteColor,
                          height: kBottomBarHeight,
                          child: Center(
                            child: gradientButton(
                                title:
                                    AppLocalizations.of(context)?.kSubmitLabel,
                                onPress: () {
                                  var bloc = context.read<HouseHoldBloc>();
                                  bloc.checkValidation();
                                  if (bloc.validationMessage == 'success') {
                                    bloc.checkValidationResident();
                                    if (bloc.residentValidationMessage ==
                                        'successs') {
                                      bloc.createHousehold();
                                    } else {
                                      showCommonDialog(
                                          context: context,
                                          dialogWidget: ErrorDialogView(
                                              errorMessage: bloc
                                                  .residentValidationMessage));
                                    }
                                  } else {
                                    showCommonDialog(
                                        context: context,
                                        dialogWidget: ErrorDialogView(
                                            errorMessage:
                                                bloc.validationMessage));
                                  }
                                },
                                context: context),
                          )),
            ),
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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppData.shared.getSmallFontSize(),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: AppData.shared.getSmallFontSize(),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  /// already registration view
  Widget _buildHouseHoldRegistration(
      BuildContext context,
      String reDate,
      String moveInDate,
      String number,
      List<HouseHoldInformation> houseHoldData,
      HouseHoldBloc bloc) {
    final List<String> titles = [
      'Owner',
      AppLocalizations.of(context)?.kNameLabel ?? '',
      AppLocalizations.of(context)?.kGenderLabel ?? '',
      AppLocalizations.of(context)?.kDobLabel ?? '',
      AppLocalizations.of(context)?.kRaceLabel ?? '',
      AppLocalizations.of(context)?.kNationalityLabel ?? '',
      AppLocalizations.of(context)?.kNRCLabel ?? '',
      AppLocalizations.of(context)?.kContactNameLabel ?? '',
      AppLocalizations.of(context)?.kEmailAddressLabel ?? '',
      AppLocalizations.of(context)?.kRelatedToOwnerLabel ?? ''
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          _listItem(
              title: AppLocalizations.of(context)?.kRegistrationDateLabel ?? '',
              value: reDate),
          10.vGap,
          _listItem(
              title: AppLocalizations.of(context)?.kMoveInDateLabel ?? '',
              value: moveInDate),
          10.vGap,
          _listItem(
              title: AppLocalizations.of(context)?.kEmergencyLabel ?? '',
              value: number),
          kSize18.vGap,
          Container(
            decoration: BoxDecoration(
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
                              color: kInputBackgroundColor,
                              padding: EdgeInsets.only(bottom: kMargin10),
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
                                              : FontWeight.w700,
                                          fontSize: kTextRegular),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(bottom: kMargin10),
                          color: kThirdGrayColor,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            child: Row(
                              children:
                                  houseHoldData.asMap().entries.map((entry) {
                                return InkWell(
                                  onTap: () {
                                    PageNavigator(ctx: context)
                                        .nextPage(
                                            page: EditResidentPage(
                                      houseHoldData: houseHoldData[entry.key],
                                      id: bloc.householdList.first.id,
                                    ))
                                        .whenComplete(() async {
                                      await bloc.getHouseHoldLists();
                                    });
                                  },
                                  child: ResidentListItem(
                                    houseHoldData: houseHoldData[entry.key],
                                    index: entry.key,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),

          20.vGap,

          ///add resident button
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () => PageNavigator(ctx: context)
                    .nextPage(
                        page: AddResidentPage(
                      id: bloc.householdList.first.id,
                    ))
                    .whenComplete(() async => await bloc.getHouseHoldLists()),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kMargin10),
                  height: kSize33 - 2,
                  decoration: BoxDecoration(
                      color: kDarkBlueColor,
                      borderRadius: BorderRadius.circular(kMarginMedium)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)?.kAddResidentLabel ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kWhiteColor),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //add new registration view
  Widget _buildRegistrationForm() {
    return Consumer<HouseHoldBloc>(
      builder: (context, bloc, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: kMarginMedium2,
          children: [
            InkWell(
                onTap: () => bloc.showDate(isRegistration: true),
                child: _buildDatePicker(
                    AppLocalizations.of(context)?.kRegistrationDateLabel ?? '',
                    bloc.registrationDate ?? '')),
            InkWell(
                onTap: () => bloc.showDate(isMoveIn: true),
                child: _buildDatePicker(
                    AppLocalizations.of(context)?.kMoveInDateLabel ?? '',
                    bloc.moveInDate ?? '')),
            _buildInputField(
                title: AppLocalizations.of(context)?.kEmergencyContactLabel),
            _buildOwnerInformation(),
            _buildResidentInformationForm(context),
            kSize70.vGap
          ],
        ),
      ),
    );
  }

  ///resident list view
  // Widget _buildResidentField(
  //     {required ResidentVo? residentData, required int index}) {
  //   return Consumer<HouseHoldBloc>(
  //     builder: (context, bloc, child) => ListTileTheme(
  //       dense: true,
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: kPrimaryColor,
  //             borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(kMargin10),
  //                 bottomRight: Radius.circular(kMargin10))),
  //         child: ExpansionTile(
  //           key: Key(bloc.selectedExpensionIndex.toString()),
  //           initiallyExpanded: bloc.selectedExpensionIndex == index,
  //           onExpansionChanged: (isExpanded) {
  //             if (isExpanded) {
  //               bloc.selectedExpensionIndex = index;
  //             } else {
  //               bloc.selectedExpensionIndex = -1;
  //             }
  //             bloc.changeExpansion();
  //           },
  //           collapsedIconColor: kWhiteColor,
  //           iconColor: kWhiteColor,
  //           shape: Border(),
  //           title: Text(residentData?.name ?? '',
  //               style: TextStyle(
  //                   fontFamily: AppData.shared.fontFamily2,
  //                   fontSize: kTextRegular3x,
  //                   color: kWhiteColor,
  //                   fontWeight: FontWeight.w600)),
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                   color: kBackgroundColor,
  //                   borderRadius: BorderRadius.only(
  //                       bottomLeft: Radius.circular(kMargin10),
  //                       bottomRight: Radius.circular(kMargin10))),
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: kMargin10),
  //                 child: Column(
  //                   spacing: kMarginMedium2,
  //                   children: [
  //                     1.vGap,
  //                     _buildInputField(
  //                         title: kNameLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.name),
  //                     _buildInputField(
  //                         title: kGenderLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.data.gender),
  //                     _buildInputField(
  //                         title: kDobLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.data.dob),
  //                     _buildInputField(
  //                         title: kRaceLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.data.race),
  //                     _buildInputField(
  //                         title: kNationalityLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.data.nationality),
  //                     _buildInputField(
  //                         title: kNRCLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.data.nrcOrpassport),
  //                     _buildInputField(
  //                         title: kContactNumberLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.data.contactNumber),
  //                     _buildInputField(
  //                         title: kRelatedToOwnerLabel,
  //                         isReadOnly: true,
  //                         value: residentData?.data.relatedTo),

  //                     ///delete button
  //                     Consumer<HouseHoldBloc>(
  //                       builder: (_, bloc, child) => Row(children: [
  //                         Spacer(),
  //                         IconButton(
  //                             onPressed: () =>
  //                                 bloc.removeResident(index: index),
  //                             icon: Image.asset(
  //                               kDeleteIcon,
  //                               width: kSize28,
  //                               height: kSize28,
  //                               color: kBlackColor,
  //                             ))
  //                       ]),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //date picker
  Widget _buildDatePicker(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: AppData.shared.getSmallFontSize(),
              fontWeight: FontWeight.w600),
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
                    fontWeight: FontWeight.w600,
                    fontSize: AppData.shared.getSmallFontSize()),
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
  Widget _buildGenderDropDown({bool? isOwner}) {
    return Consumer<HouseHoldBloc>(
      builder: (_, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.kGenderLabel ?? '',
            style: TextStyle(
                fontSize: AppData.shared.getSmallFontSize(),
                fontWeight: FontWeight.w600),
          ),
          4.vGap,
          Container(
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                  value: bloc.residentGender,
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                      AppLocalizations.of(context)?.kSelectGenderLabel ?? ''),
                  items: genders.map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: ((value) {
                    if (isOwner == true) {
                      bloc.onSelectOwnerGender(value ?? '');
                    } else {
                      bloc.onSelectResidentGender(value ?? '');
                    }
                  })),
            ),
          )
        ],
      ),
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
          style: TextStyle(
              fontSize: AppData.shared.getSmallFontSize(),
              fontWeight: FontWeight.w600),
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
                    child: Text(
                      value ?? '',
                      style: TextStyle(
                          fontSize: AppData.shared.getSmallFontSize()),
                    ),
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
    return Consumer<HouseHoldBloc>(
      builder: (context, bloc, child) => Container(
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
                padding:
                    EdgeInsets.only(left: AppData.shared.getSmallFontSize()),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kMargin10),
                      topRight: Radius.circular(kMargin10)),
                  gradient: LinearGradient(
                    colors: [kPrimaryColor, kThirdColor],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      AppLocalizations.of(context)?.kOwnerInformationLabel ??
                          '',
                      style: TextStyle(
                          fontFamily: AppData.shared.fontFamily2,
                          fontSize: AppData.shared.getExtraFontSize(),
                          color: kWhiteColor,
                          fontWeight: FontWeight.w600)),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMargin10),
              child: Column(
                children: [
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kOwnerNameLabel),
                  12.vGap,
                  _buildGenderDropDown(),
                  12.vGap,
                  InkWell(
                      onTap: () => bloc.showDate(isOwner: true),
                      child: _buildDatePicker(
                          AppLocalizations.of(context)?.kDobLabel ?? '',
                          bloc.ownerDob ?? '')),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kRaceLabel),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kNationalityLabel),
                  12.vGap,
                  _buildNRCAndPassportRadioButton(isOwner: true),
                  _selectedOwnerNRC == 'Citizen'
                      ? _buildOwnerNRCPickerView()
                      : _buildInputField(
                          title: 'Passport',
                        ),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kContactNumberLabel),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kEmailAddressLabel),
                  12.vGap,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///resident information
  Widget _buildResidentInformationForm(BuildContext context) {
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
                padding: EdgeInsets.only(
                  left: AppData.shared.getSmallFontSize(),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kMargin10),
                      topRight: Radius.circular(kMargin10)),
                  gradient: LinearGradient(
                    colors: [kPrimaryColor, kThirdColor],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      AppLocalizations.of(context)?.kResidentInformationLabel ??
                          '',
                      style: TextStyle(
                          fontFamily: AppData.shared.fontFamily2,
                          fontSize: PersistenceData.shared.getLocale() == 'my'
                              ? AppData.shared.getRegularFontSize() + 2
                              : AppData.shared.getExtraFontSize(),
                          color: kWhiteColor,
                          fontWeight: FontWeight.w600)),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMargin10),
              child: Consumer<HouseHoldBloc>(
                builder: (_, bloc, child) => Column(
                  children: [
                    12.vGap,
                    _buildInputField(
                        title: AppLocalizations.of(context)?.kNameLabel,
                        controller: bloc.residentNameController),
                    12.vGap,
                    _buildGenderDropDown(),
                    12.vGap,
                    InkWell(
                        onTap: () => bloc.showDate(isResident: true),
                        child: _buildDatePicker(
                            AppLocalizations.of(context)?.kDobLabel ?? '',
                            bloc.residentDob ?? '')),
                    12.vGap,
                    _buildInputField(
                        title: AppLocalizations.of(context)?.kRaceLabel,
                        controller: bloc.residentRaceController),
                    12.vGap,
                    _buildInputField(
                        title: AppLocalizations.of(context)?.kNationalityLabel,
                        controller: bloc.residentNationalityController),
                    12.vGap,
                    _buildNRCAndPassportRadioButton(),
                    _selectedOption == 'Citizen'
                        ? _buildNRCPickerView()
                        : _buildInputField(
                            title: 'Passport',
                            controller: bloc.residentPassportController),
                    12.vGap,
                    _buildInputField(
                        title:
                            AppLocalizations.of(context)?.kContactNumberLabel,
                        controller: bloc.residentContactController),
                    12.vGap,
                    _buildInputField(
                        title:
                            AppLocalizations.of(context)?.kRelatedToOwnerLabel,
                        controller: bloc.residentRelatedToController),
                    12.vGap,

                    /// add resident button
                    // Row(
                    //   children: [
                    //     Spacer(),
                    //     InkWell(
                    //       onTap: () {
                    //         // var residentVo = ResidentVo(
                    //         //     bloc.residentNameController.text.trim(),
                    //         //     ResidentDataVo(
                    //         //         name: bloc.residentContactController.text
                    //         //             .trim(),
                    //         //         race:
                    //         //             bloc.residentRaceController.text.trim(),
                    //         //         nationality: bloc
                    //         //             .residentNationalityController.text
                    //         //             .trim(),
                    //         //         contactNumber: bloc
                    //         //             .residentContactController.text
                    //         //             .trim(),
                    //         //         relatedTo: bloc
                    //         //             .residentRelatedToController.text
                    //         //             .trim(),
                    //         //         gender: bloc.residentGender,
                    //         //         dob: bloc.residentDate,
                    //         //         nrcOrpassport: _selectedOption == 'Citizen'
                    //         //             ? residentNrc ?? '-'
                    //         //             : bloc.residentPassportController.text
                    //         //                 .trim()));
                    //         // bloc.checkValidationResident();
                    //         // bloc.residentValidationMessage != 'success'
                    //         //     ? showCommonDialog(
                    //         //         context: context,
                    //         //         dialogWidget: ErrorDialogView(
                    //         //             errorMessage:
                    //         //                 bloc.residentValidationMessage))
                    //         //     : bloc.addResident(resident: residentVo);
                    //       },
                    //       child: Container(
                    //         height: kSize33,
                    //         padding: EdgeInsets.only(
                    //             top: kMargin5,
                    //             left: kMargin5 + 2,
                    //             right: kMargin5 + 2),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(
                    //               kMargin10,
                    //             ),
                    //             border: Border.all(color: kPrimaryColor)),
                    //         child: Text(
                    //           kAddResidentLabel,
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w600,
                    //               color: kPrimaryColor),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            // 20.vGap,
            // Consumer<HouseHoldBloc>(
            //     builder: (context, bloc, child) => Column(
            //   spacing: kMargin10,
            //   children: bloc.residentVo.asMap().entries.map((data) {
            //     return _buildResidentField(
            //         residentData: data.value, index: data.key);
            //   }).toList(),
            // )),
          ],
        ),
      ),
    );
  }

  ///nrc picker
  Widget _buildNRCPickerView() {
    return Consumer<HouseHoldBloc>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NRC',
            style: TextStyle(
                fontSize: AppData.shared.getSmallFontSize(),
                fontWeight: FontWeight.w600),
          ),
          4.vGap,
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
              decoration: BoxDecoration(
                  color: kInputBackgroundColor,
                  borderRadius: BorderRadius.circular(kMarginMedium)),
              child: NRCView(
                type: 'resident',
              )),
        ],
      ),
    );
  }

  //owner nrc picker

  Widget _buildOwnerNRCPickerView() {
    return Consumer<HouseHoldBloc>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NRC',
            style: TextStyle(
                fontSize: AppData.shared.getSmallFontSize(),
                fontWeight: FontWeight.w600),
          ),
          4.vGap,
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
              decoration: BoxDecoration(
                  color: kInputBackgroundColor,
                  borderRadius: BorderRadius.circular(kMarginMedium)),
              child: OwnerNrcView()),
        ],
      ),
    );
  }

  ///radio button
  Widget _buildNRCAndPassportRadioButton({bool? isOwner}) {
    return Consumer<HouseHoldBloc>(
      builder: (context, bloc, child) => Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // Align the items to the start
        children: [
          SizedBox(
            width: 138,
            child: Theme(
              data: Theme.of(context).copyWith(
                listTileTheme: ListTileThemeData(
                  horizontalTitleGap: 4,
                ),
              ),
              child: RadioListTile<String>(
                title: Text("Citizen"),
                value: "Citizen",
                groupValue:
                    isOwner == true ? _selectedOwnerNRC : _selectedOption,
                onChanged: (value) {
                  setState(() {
                    isOwner == true
                        ? _selectedOwnerNRC = value!
                        : _selectedOption = value!;

                    isOwner == true
                        ? bloc.onChangeOwnerNRCType(value)
                        : bloc.onChangeResidentNRCType(value);
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                listTileTheme: ListTileThemeData(
                  horizontalTitleGap: 4,
                ),
              ),
              child: RadioListTile<String>(
                title: Text("Foreigner"),
                value: "Foreigner",
                groupValue:
                    isOwner == true ? _selectedOwnerNRC : _selectedOption,
                onChanged: (value) {
                  setState(() {
                    isOwner == true
                        ? _selectedOwnerNRC = value!
                        : _selectedOption = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
