import 'package:flutter/material.dart';
import 'package:mm_nrc_kit/mm_nrc_kit.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/edit_house_hold_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/images.dart';

import '../../utils/colors.dart';
import '../../utils/date_formatter.dart';
import '../../utils/dimens.dart';
import '../../utils/strings.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';

class EditResidentPage extends StatefulWidget {
  const EditResidentPage({super.key});

  @override
  State<EditResidentPage> createState() => _EditResidentPageState();
}

class _EditResidentPageState extends State<EditResidentPage> {
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditHouseHoldBlocc(context),
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
          ],
        ),
        bottomNavigationBar: Container(
            color: kWhiteColor,
            height: kBottomBarHeight,
            child: Center(
              child: gradientButton(title: kSubmitLabel, onPress: () {}),
            )),
      ),
    );
  }

  Widget _buildEditForm() {
    return Consumer<EditHouseHoldBlocc>(
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
                  _buildInputField(
                      title: kNameLabel,
                      controller: bloc.residentNameController),
                  _buildGenderDropDown(),
                  InkWell(
                      onTap: () => bloc.showDate(),
                      child: _buildDateOfBirthDatePicker(
                          value: DateFormatter.formatDate(bloc.selectedDate))),
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

  Widget _buildNRCPickerView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        kNRCLabel,
        style: TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
      ),
      4.vGap,
      Consumer<EditHouseHoldBlocc>(
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
