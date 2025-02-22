// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Consumer<EditResidentBloc>(
                builder: (context, bloc, child) => Positioned(
                    top: 0,
                    child: ProfileAppbar(
                      title: AppLocalizations.of(context)?.kEditLabel,
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
                            GestureDetector(
                              onTap: () => bloc
                                  .onTapDelete()
                                  .then((_) => Navigator.of(context).pop()),
                              child: Image.asset(
                                kDeleteIcon,
                                width: kSize28,
                                height: kSize28,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),

              ///loading
              if (loading == true) LoadingView()
            ],
          ),
        ),
        bottomNavigationBar: Consumer<EditResidentBloc>(
          builder: (context, bloc, child) => Container(
              color: kWhiteColor,
              height: kBottomBarHeight,
              child: Center(
                child: gradientButton(
                    title: AppLocalizations.of(context)?.kSubmitLabel,
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
                    },
                    context: context),
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
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMargin10),
              child: Column(
                children: [
                  1.vGap,
                  _buildTypeDropDown(),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kNameLabel,
                      controller: bloc.nameController),
                  12.vGap,
                  _buildGenderDropDown(),
                  12.vGap,
                  GestureDetector(
                      onTap: () => bloc.showDate(),
                      child: _buildDateOfBirthDatePicker(
                          value: DateFormatter.formatDate(bloc.selectedDate))),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kRaceLabel,
                      controller: bloc.raceController),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kNationalityLabel,
                      controller: bloc.nationalityController),
                  12.vGap,
                  _buildNRCAndPassportRadioButton(),
                  _selectedOption == 'Citizen'
                      ? _buildNRCPickerView()
                      : _buildInputField(
                          title: AppLocalizations.of(context)?.kPassportLabel,
                          controller: bloc.passportController),
                  12.vGap,
                  _buildInputField(
                      title: AppLocalizations.of(context)?.kContactNumberLabel,
                      isNumber: true,
                      controller: bloc.contactController),
                  12.vGap,
                  bloc.type == 'Owner'
                      ? _buildInputField(
                          title:
                              AppLocalizations.of(context)?.kEmailAddressLabel,
                          controller: bloc.emailAddressController)
                      : _buildInputField(
                          title: AppLocalizations.of(context)
                              ?.kRelatedToOwnerLabel,
                          controller: bloc.relatedToController),
                  12.vGap,
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
            AppLocalizations.of(context)?.kGenderLabel ?? '',
            style:
                TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w600),
          ),
          4.vGap,
          Container(
            decoration: BoxDecoration(
                color: isEditDeleteForm == true
                    ? kWhiteColor
                    : kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                  value: bloc.gender,
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                      AppLocalizations.of(context)?.kSelectGenderLabel ?? ''),
                  items: genders.map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: ((value) {
                    bloc.onChangeGender(value ?? '');
                  })),
            ),
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
            AppLocalizations.of(context)?.kTypeLabel ?? '',
            style:
                TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w600),
          ),
          4.vGap,
          Container(
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: ButtonTheme(
              alignedDropdown: true,
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
            ),
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
          AppLocalizations.of(context)?.kDobLabel ?? '',
          style: TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w600),
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
                style: TextStyle(fontSize: kTextRegular),
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
            style:
                TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w600),
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
                      textInputAction: title ==
                                  AppLocalizations.of(context)
                                      ?.kRelatedToOwnerLabel ||
                              title ==
                                  AppLocalizations.of(context)
                                      ?.kEmailAddressLabel
                          ? TextInputAction.done
                          : TextInputAction.next,
                      controller: controller,
                      keyboardType: isNumber == true
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: title,
                          hintStyle: TextStyle(fontSize: kTextRegular)),
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
          style: TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w600),
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
                  : widget.houseHoldData?.nrc?.isEmpty ?? true
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
