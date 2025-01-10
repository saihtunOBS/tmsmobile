import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/network/requests/household_resident_request.dart';
import 'package:tmsmobile/utils/date_formatter.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

String? addNrcNumber;

class AddResidentBloc extends ChangeNotifier {
  int selectedExpensionIndex = -1;
  String? gender;
  BuildContext? context;
  DateTime selectedDate = DateTime.now();

  // Define selected values
  bool isLoading = false;
  bool isDisposed = false;
  String validationMessage = '';
  var token = '';
  String? id;
  String nrcType = 'Citizen';

  AddResidentBloc({this.context, this.id}) {
    addNrcNumber = null;
    id = id;
    token = PersistenceData.shared.getToken();
  }

  var residentNameController = TextEditingController();
  var residentRaceController = TextEditingController();
  var residentNationalityController = TextEditingController();
  var residentContactController = TextEditingController();
  var residentRelatedToController = TextEditingController();
  var passportController = TextEditingController();

  final TmsModel _tmsModel = TmsModelImpl();

  void onChangedNrc(String nrc) {
    addNrcNumber = nrc;
    debugPrint("NewNrcNumner>>>>>>>>>>>>$addNrcNumber");
    notifyListeners();
  }

  Future onTapSubmit() {
    _showLoading();
    var request = HouseholdResidentRequest(
        type: 2,
        name: residentNameController.text.trim(),
        gender: gender,
        dateOfBirth: DateFormatter.formatDate(selectedDate),
        race: residentRaceController.text.trim(),
        nationality: residentNationalityController.text.trim(),
        nrc: nrcType == 'Citizen'
            ? addNrcNumber
            : passportController.text.trim(),
        nrcType: nrcType == 'Citizen' ? 1 : 2,
        contactNumber: residentContactController.text.trim(),
        relatedToOwner: residentRelatedToController.text.trim());

    return _tmsModel
        .addResident(token, id ?? '', request)
        .whenComplete(() => _hideLoading());
  }

  void onChangeGender(String value) {
    gender = value;
    notifyListeners();
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

  onChangeNrcType(String value) {
    nrcType = value;
    notifyListeners();
  }

  checkResidentValidation() {
    if (residentNameController.text.isEmpty) {
      validationMessage = 'Name is required!';
    } else if (gender == null) {
      validationMessage = 'Gender is required!';
    } else if (residentRaceController.text.isEmpty) {
      validationMessage = 'Race is required!';
    } else if (residentNationalityController.text.isEmpty) {
      validationMessage = 'Nationality is required!';
    }
    // else if (addNrcNumber == null) {
    //   validationMessage = 'NRC is required!';
    // }
    else if (residentContactController.text.isEmpty) {
      validationMessage = 'Contact Number is required!';
    } else if (residentRelatedToController.text.isEmpty) {
      validationMessage = 'Related to Owner is required!';
    } else {
      validationMessage = 'success';
    }
    notifyListeners();
  }

  Future<void> showDate() async {
    await showCupertinoModalPopup<void>(
      context: context!,
      builder: (_) {
        final size = MediaQuery.of(context!).size;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          height: size.height * 0.27,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              selectedDate = value;
              notifyListeners();
            },
          ),
        );
      },
    );
  }
}
