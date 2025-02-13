import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/network/requests/household_owner_request.dart';
import 'package:tmsmobile/network/requests/household_registration_request.dart';
import 'package:tmsmobile/network/requests/household_resident_request.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

String? editNrcNumber;

class EditResidentBloc extends ChangeNotifier {
  int selectedExpensionIndex = -1;
  String? gender;
  BuildContext? context;
  DateTime selectedDate = DateTime.now();
  bool isValidate = false;
  String validationMessage = '';
  String? type;
  String? nrcType = '';
  String? responseNrc;
  bool isLoading = false;
  bool isDisposed = false;
  HouseHoldInformation? houseHoldVO;
  var token = '';
  String? houseHoldId;

  EditResidentBloc({this.context, this.houseHoldVO, this.houseHoldId}) {
    token = PersistenceData.shared.getToken();
    editNrcNumber = null;
    responseNrc = houseHoldVO?.nrc;
    type = houseHoldVO?.type == 1 ? 'Owner' : 'Resident';
    nrcType = houseHoldVO?.nrcType == 1 ? 'Citizen' : 'Foreigner';
    gender = houseHoldVO?.gender;
    nameController.text = houseHoldVO?.name ?? '';
    selectedDate = houseHoldVO?.dateOfBirth ?? DateTime.now();

    raceController.text = houseHoldVO?.race ?? '';
    nationalityController.text = houseHoldVO?.nationality ?? '';
    contactController.text = houseHoldVO?.contactNumber ?? '';
    relatedToController.text = houseHoldVO?.relatedToOwner ?? '';
    emailAddressController.text = houseHoldVO?.email ?? '';
    if (houseHoldVO?.nrcType == 2) {
      passportController.text = houseHoldVO?.nrc ?? '';
    }

    RegExp regex = RegExp(r'^(\d+)/([a-zA-Z]+)\((\w)\)(\d+)$');
    Match? match = regex.firstMatch(houseHoldVO?.nrc ?? '');

    if (match != null) {
      editNrcNumber = houseHoldVO?.nrc;
    }
  }

  var nameController = TextEditingController();
  var raceController = TextEditingController();
  var nationalityController = TextEditingController();
  var contactController = TextEditingController();
  var relatedToController = TextEditingController();
  var emailAddressController = TextEditingController();
  var passportController = TextEditingController();

  final TmsModel _tmsModel = TmsModelImpl();

  Future onTapSubmit() {
    _showLoading();
    if (type == 'Owner') {
      var request = HouseholdOwnerRequest(
          type: 1,
          name: nameController.text.trim(),
          gender: gender,
          dateOfBirth: DateFormatter.formatDate(selectedDate),
          race: raceController.text.trim(),
          nationality: nationalityController.text.trim(),
          nrc: nrcType == 'Citizen'
              ? editNrcNumber ?? ''
              : passportController.text.trim(),
          nrcType: nrcType == 'Citizen' ? 1 : 2,
          contactNumber: contactController.text.trim(),
          email: emailAddressController.text.trim());

      return _tmsModel
          .updateHouseHoldOwner(
              token, houseHoldId ?? '', houseHoldVO?.id ?? '', request)
          .whenComplete(() => _hideLoading());
    } else {
      var request = HouseholdResidentRequest(
          type: 2,
          name: nameController.text.trim(),
          gender: gender,
          dateOfBirth: DateFormatter.formatDate(selectedDate),
          race: raceController.text.trim(),
          nationality: nationalityController.text.trim(),
          nrc: nrcType == 'Citizen'
              ? editNrcNumber ?? ''
              : passportController.text.trim(),
          nrcType: nrcType == 'Citizen' ? 1 : 2,
          contactNumber: contactController.text.trim(),
          relatedToOwner: relatedToController.text.trim());

      return _tmsModel
          .updateHouseHoldResident(
              token, houseHoldId ?? '', houseHoldVO?.id ?? '', request)
          .whenComplete(() => _hideLoading());
    }
  }

  Future onTapDelete() {
    _showLoading();
    return _tmsModel
        .deleteHouseHold(token, houseHoldId ?? '', houseHoldVO?.id ?? '')
        .whenComplete(() => _hideLoading());
  }

  _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void onChangedNrctype(String nrc) {
    nrcType = nrc;
    notifyListeners();
  }

  void onChangedEditNrc(String nrc) {
    editNrcNumber = nrc;
    debugPrint("NewNrcNumner>>>>>>>>>>>>$editNrcNumber");
  }

  void onChangeGender(String value) {
    gender = value;
    notifyListeners();
  }

  void onChangeType(String value) {
    type = value;
    notifyListeners();
  }

  String checkResidentValidation() {
    if (type == null) {
      validationMessage = 'Type is required!';
    } else if (nameController.text.isEmpty) {
      validationMessage = 'Name is required!';
    } else if (gender == null) {
      validationMessage = 'Gender is required!';
    } else if (raceController.text.isEmpty) {
      validationMessage = 'Race is required!';
    } else if (nationalityController.text.isEmpty) {
      validationMessage = 'Nationality is required!';
    }
    // else if (editNrcNumber == null) {
    //   validationMessage = 'NRC is required!';
    // }
    else if (contactController.text.isEmpty) {
      validationMessage = 'Contact Number is required!';
    } else {
      if (type == 'Owner') {
        if (emailAddressController.text.isEmpty) {
          validationMessage = 'Email address is required!';
        } else {
          return validationMessage = 'success';
        }
      } else {
        if (relatedToController.text.isEmpty) {
          validationMessage = 'Related to owner is required!';
        } else {
          return validationMessage = 'success';
        }
      }
    }

    return validationMessage;
  }

  Future<void> showDate() async {
    await showCupertinoModalPopup<void>(
      context: context!,
      builder: (_) {
        final size = MediaQuery.of(context!).size;
        return Container(
          decoration: const BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          height: size.height * 0.27,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: houseHoldVO?.dateOfBirth,
                  maximumYear: DateTime.now().year,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    selectedDate = value;
                    notifyListeners();
                  },
                ),
              ),
              5.vGap,
              Material(
                color: kWhiteColor,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context!),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: kMargin24, right: kMargin24,bottom: kMargin24),
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: kDarkBlueColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                            color: kWhiteColor, fontWeight: FontWeight.w700,fontSize: kTextRegular),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
