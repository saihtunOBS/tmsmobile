import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/resident_vo.dart';
import 'package:tmsmobile/utils/date_formatter.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';
import '../data/vos/resident_data_vo.dart';
import 'nrc_bloc.dart';

String? ownerNrc;
String? residentNrc;

class HouseHoldBloc extends ChangeNotifier {
  List<ResidentVo> residentVo = [];

  BuildContext? context;
  int selectedExpensionIndex = -1;
  String? residentGender;
  String? ownerGender;

  var emergencyController = TextEditingController();

  var residentNameController = TextEditingController();
  var residentRaceController = TextEditingController();
  var residentNationalityController = TextEditingController();
  var residentContactController = TextEditingController();
  var residentRelatedToController = TextEditingController();
  var residentPassportController = TextEditingController();

  var ownerNameController = TextEditingController();
  var ownerRaceController = TextEditingController();
  var ownerNationalityController = TextEditingController();
  var ownerContactController = TextEditingController();
  var ownerRelatedToController = TextEditingController();
  var ownerPassportController = TextEditingController();
  var ownerEmailAddressController = TextEditingController();

  String? validationMessage = '';
  String? residentValidationMessage = '';
  List<HouseHoldVO> householdList = [];

  String? registrationDate;
  String? moveInDate;
  String? ownerDob;
  String? residentDate;

  bool isLoading = false;
  bool isDisposed = false;
  ResidentDataObject? owner;
  List<ResidentDataObject> residents = [];

  final TmsModel _tmsModel = TmsModelImpl();

  HouseHoldBloc({this.context}) {
    ownerNrc = null;
    residentNrc = null;
    var token = PersistenceData.shared.getToken();
    getHouseHoldLists(token);
    registrationDate = DateFormatter.formatDate(DateTime.now());
    moveInDate = DateFormatter.formatDate(DateTime.now());
    ownerDob = DateFormatter.formatDate(DateTime.now());
    residentDate = DateFormatter.formatDate(DateTime.now());
  }

  getHouseHoldLists(token) {
    _showLoading();
    _tmsModel.getHouseHoldList(token).then((response) {
      householdList = response;
      _hideLoading();
    });
    notifyListeners();
  }

  addResident({required ResidentVo resident}) {
    residentVo.add(resident);
    residentGender = null;
    residentNameController.clear();
    residentRaceController.clear();
    residentNationalityController.clear();
    residentContactController.clear();
    residentRelatedToController.clear();
    residentPassportController.clear();
    residentNrc = null;
    var bloc = context?.read<NRCBloc>();
    bloc?.nrcNumber = null;
    notifyListeners();
  }

  removeResident({required int index}) {
    residentVo.removeAt(index);
    selectedExpensionIndex = -1;
    notifyListeners();
  }

  onSelectResidentGender(String value) {
    residentGender = value;
    notifyListeners();
  }

  onSelectOwnerGender(String value) {
    ownerGender = value;
    notifyListeners();
  }

  changeExpansion() {
    notifyListeners();
  }

  void onChangedNrcOwner(String nrc) {
    ownerNrc = nrc;
    notifyListeners();
  }

  void onChangedNrcResident(String nrc) {
    residentNrc = nrc;
    notifyListeners();
  }

  checkValidation() {
    if (emergencyController.text.isEmpty) {
      validationMessage = 'Emergency contact number is required!';
    } else if (ownerNameController.text.isEmpty) {
      validationMessage = 'Owner Name is required!';
    } else if (ownerGender == null) {
      validationMessage = 'Owner Gender is required!';
    } else if (ownerRaceController.text.isEmpty) {
      validationMessage = 'Owner Race is required!';
    } else if (ownerNationalityController.text.isEmpty) {
      validationMessage = 'Owner Nationality is required!';
    }
    // else if (ownerNrc == null) {
    //   validationMessage = 'Owner NRC is required!';
    // }
    else if (ownerContactController.text.isEmpty) {
      validationMessage = 'Owner Contact Number is required!';
    } else if (ownerEmailAddressController.text.isEmpty) {
      validationMessage = 'Owner email address is required!';
    } else {
      validationMessage = 'success';
    }
    notifyListeners();
  }

  checkValidationResident() {
    if (residentNameController.text.isEmpty) {
      residentValidationMessage = 'Resident Name is required!';
    } else if (residentGender == null) {
      residentValidationMessage = 'Resident Gender is required!';
    } else if (residentRaceController.text.isEmpty) {
      residentValidationMessage = 'Resident Race is required!';
    } else if (residentNationalityController.text.isEmpty) {
      residentValidationMessage = 'Resident Nationality is required!';
    }
    // else if (residentNrc == null) {
    //   residentValidationMessage = 'Resident NRC is required!';
    // }
    else if (residentContactController.text.isEmpty) {
      residentValidationMessage = 'Resident Contact Number is required!';
    } else if (residentRelatedToController.text.isEmpty) {
      residentValidationMessage = 'Resident Related to Owner is required!';
    } else {
      residentValidationMessage = 'success';
    }
  }

  Future<void> showDate(
      {bool? isRegistration,
      bool? isMoveIn,
      bool? isOwner,
      bool? isResident}) async {
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
              if (isRegistration == true) {
                registrationDate = DateFormatter.formatDate(value);
              } else if (isMoveIn == true) {
                moveInDate = DateFormatter.formatDate(value);
              } else if (isOwner == true) {
                ownerDob = DateFormatter.formatDate(value);
              } else if (isResident == true) {
                residentDate = DateFormatter.formatDate(value);
              }

              notifyListeners();
            },
          ),
        );
      },
    );
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

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
