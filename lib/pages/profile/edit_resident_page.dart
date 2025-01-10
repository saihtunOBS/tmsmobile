// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/edit_resident_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/network/requests/household_registration_request.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

import '../../utils/colors.dart';
import '../../utils/date_formatter.dart';
import '../../utils/dimens.dart';
import '../../utils/strings.dart';
import '../../widgets/appbar.dart';
import '../../widgets/common_dialog.dart';
import '../../widgets/error_dialog_view.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/nrc_view.dart';

class EditResidentPage extends StatefulWidget {
  const EditResidentPage(
      {super.key, required this.houseHoldData, required this.id});
  final HouseHoldInformation? houseHoldData;
  final String id;

  @override
  State<EditResidentPage> createState() => _EditResidentPageState();
}

class _EditResidentPageState extends State<EditResidentPage> {
  String _selectedOption = "Citizen";

  @override
  void initState() {
    if (widget.houseHoldData?.nrcType == 1) {
      _selectedOption = 'Citizen';
      setState(() {});
    } else {
      _selectedOption = 'Foreigner';
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditResidentBloc(
          context: context,
          houseHoldVO: widget.houseHoldData,
          houseHoldId: widget.id),
      child: Scaffold(
        body: Selector<EditResidentBloc, bool?>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, loading, child) => Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: kMarginMedium2,
                  right: kMarginMedium2,
                ),
                child: _buildEditForm(),
              ),

              ///appbar
              Positioned(
                  top: 0,
                  child: ProfileAppbar(
                    title: kEditLabel,
                    action: Padding(
                      padding: const EdgeInsets.only(right: kMargin24),
                      child: Row(
                        spacing: kMargin5,
                        children: [
                          Image.asset(
                            kEditIcon,
                            width: kSize28,
                            height: kSize28,
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            kDeleteIcon,
                            width: kSize28,
                            height: kSize28,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  )),

              ///loading
              if (loading == true)
                LoadingView(
                    indicator: Indicator.ballBeat,
                    indicatorColor: kPrimaryColor)
            ],
          ),
        ),
        bottomNavigationBar: Consumer<EditResidentBloc>(
          builder: (context, bloc, child) => Container(
              color: kWhiteColor,
              height: kBottomBarHeight,
              child: Center(
                child: gradientButton(
                    title: kSubmitLabel,
                    onPress: () {
                      bloc.checkResidentValidation();

                      // print(bloc.isValidate);
                      bloc.validationMessage != 'success'
                          ? showCommonDialog(
                              context: context,
                              dialogWidget: ErrorDialogView(
                                  errorMessage: bloc.validationMessage))
                          : bloc.onTapSubmit().then((value) {
                              Navigator.pop(context);
                            }).catchError((error) {
                              showCommonDialog(
                                  context: context,
                                  dialogWidget: ErrorDialogView(
                                      errorMessage: error.toString()));
                            });
                    }),
              )),
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Consumer<EditResidentBloc>(
      builder: (context, bloc, child) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMargin10),
              child: Column(
                spacing: kMarginMedium2,
                children: [
                  1.vGap,
                  _buildTypeDropDown(),
                  _buildInputField(
                      title: kNameLabel, controller: bloc.nameController),
                  _buildGenderDropDown(),
                  InkWell(
                      onTap: () => bloc.showDate(),
                      child: _buildDateOfBirthDatePicker(
                          value: DateFormatter.formatDate(bloc.selectedDate))),
                  _buildInputField(
                      title: kRaceLabel, controller: bloc.raceController),
                  _buildInputField(
                      title: kNationalityLabel,
                      controller: bloc.nationalityController),
                  _buildNRCAndPassportRadioButton(),
                  _selectedOption == 'Citizen'
                      ? _buildNRCPickerView()
                      : _buildInputField(
                          title: 'Passport',
                          controller: bloc.passportController),
                  _buildInputField(
                      title: kContactNumberLabel,
                      isNumber: true,
                      controller: bloc.contactController),
                  bloc.type == 'Owner'
                      ? _buildInputField(
                          title: kEmailAddressLabel,
                          controller: bloc.emailAddressController)
                      : _buildInputField(
                          title: kRelatedToOwnerLabel,
                          controller: bloc.relatedToController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///genre dropdown
  List<String> genders = ['Male', 'Female'];
  Widget _buildGenderDropDown({bool? isEditDeleteForm}) {
    return Consumer<EditResidentBloc>(
      builder: (context, bloc, child) => Column(
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
                  bloc.onChangeGender(value ?? '');
                })),
          )
        ],
      ),
    );
  }

  //type dropdown
  List<String> types = ['Owner', 'Resident'];
  Widget _buildTypeDropDown() {
    return Consumer<EditResidentBloc>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type',
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
          ),
          4.vGap,
          Container(
            padding: EdgeInsets.symmetric(horizontal: kMargin10),
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: DropdownButton(
                value: bloc.type,
                isExpanded: true,
                underline: Container(),
                hint: Text('Type'),
                items: types.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: ((value) {
                  bloc.onChangeType(value ?? '');
                })),
          )
        ],
      ),
    );
  }

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

  Widget _buildInputField(
      {required title,
      String? value,
      bool? isReadOnly,
      bool? isNumber,
      TextEditingController? controller}) {
    return Consumer<EditResidentBloc>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
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
                      keyboardType: isNumber == true
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: title),
                    ))
        ],
      ),
    );
  }

  ///nrc picker
  Widget _buildNRCPickerView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NRC',
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
        ),
        4.vGap,
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: NRCView(
              type: 'edit',
              editNRC: widget.houseHoldData?.nrcType == 2
                  ? null
                  : widget.houseHoldData?.nrc,
            )),
      ],
    );
  }

  ///radio button
  Widget _buildNRCAndPassportRadioButton() {
    return Consumer<EditResidentBloc>(
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
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                  bloc.onChangedNrctype(value!);
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
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                  bloc.onChangedNrctype(value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
