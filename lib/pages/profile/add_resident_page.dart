import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/add_resident_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/widgets/common_dialog.dart';
import 'package:tmsmobile/widgets/error_dialog_view.dart';

import '../../utils/colors.dart';
import '../../utils/date_formatter.dart';
import '../../utils/dimens.dart';
import '../../utils/strings.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/nrc_view.dart';

class AddResidentPage extends StatefulWidget {
  const AddResidentPage({super.key});

  @override
  State<AddResidentPage> createState() => _AddResidentPageState();
}

class _AddResidentPageState extends State<AddResidentPage> {
  String _selectedOption = "Citizen";
  String _selectedOwnerNRC = 'Citizen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddResidentBloc(),
      child: Scaffold(
        body: Stack(
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
                  title: kAddResidentLabel.replaceAll('+', ''),
                )),
          ],
        ),
        bottomNavigationBar: Consumer(
          builder: (context, value, child) => Container(
              color: kWhiteColor,
              height: kBottomBarHeight,
              child: Center(
                child: gradientButton(
                    title: kSubmitLabel,
                    onPress: () {
                      var bloc = context.read<AddResidentBloc>();
                      bloc.checkResidentValidation();
                      bloc.validationMessage != 'success'
                          ? showCommonDialog(
                              context: context,
                              dialogWidget: ErrorDialogView(
                                  errorMessage: bloc.validationMessage))
                          : print('success');
                    }),
              )),
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Consumer<AddResidentBloc>(
      builder: (context, bloc, child) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMargin10),
              child: Column(
                children: [
                  1.vGap,
                  _buildInputField(
                      title: 'Type',
                      value: 'Resident',
                      isReadOnly: true,
                      controller: bloc.residentNameController),
                  12.vGap,
                  _buildInputField(
                      title: kNameLabel,
                      controller: bloc.residentNameController),
                  12.vGap,
                  _buildGenderDropDown(),
                  12.vGap,
                  InkWell(
                      onTap: () => bloc.showDate(),
                      child: _buildDateOfBirthDatePicker(
                          value: DateFormatter.formatDate(bloc.selectedDate))),
                  12.vGap,
                  _buildInputField(
                      title: kRaceLabel,
                      controller: bloc.residentRaceController),
                  12.vGap,
                  _buildInputField(
                      title: kNationalityLabel,
                      controller: bloc.residentNationalityController),
                  12.vGap,
                  _buildNRCAndPassportRadioButton(isOwner: true),
                  _selectedOwnerNRC == 'Citizen'
                      ? _buildNRCPickerView()
                      : _buildInputField(
                          title: 'Passport',
                          controller: bloc.passportController),
                  12.vGap,
                  _buildInputField(
                      title: kContactNumberLabel,
                      isNumber: true,
                      controller: bloc.residentContactController),
                  12.vGap,
                  _buildInputField(
                      title: kRelatedToOwnerLabel,
                      controller: bloc.residentRelatedToController),
                  12.vGap,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> genders = ['Male', 'Female'];
  Widget _buildGenderDropDown({bool? isEditDeleteForm}) {
    return Consumer<AddResidentBloc>(
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
                  bloc.onChangeGender(value ?? "");
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
                    child: Text(
                      value ?? '',
                      style: TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : TextField(
                    controller: controller,
                    keyboardType: isNumber == true
                        ? TextInputType.phone
                        : TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: title),
                  ))
      ],
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
            child: NRCView(type: 'add',)),
      ],
    );
  }

  ///radio button
  Widget _buildNRCAndPassportRadioButton({bool? isOwner}) {
    return Row(
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
              groupValue: isOwner == true ? _selectedOwnerNRC : _selectedOption,
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
              groupValue: isOwner == true ? _selectedOwnerNRC : _selectedOption,
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
    );
  }
}
