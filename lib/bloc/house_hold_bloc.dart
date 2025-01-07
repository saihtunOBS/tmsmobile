import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/resident_vo.dart';
import 'package:tmsmobile/utils/date_formatter.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';
import '../data/vos/resident_data_vo.dart';
import '../network/responses/nrc_response.dart';
import '../utils/json_string.dart';

class HouseHoldBloc extends ChangeNotifier {
  List<ResidentVo> residentVo = [];

  BuildContext? context;
  String? nrc;
  int selectedExpensionIndex = -1;
  String? residentGender;
  String? ownerGender;

  var residentNameController = TextEditingController();
  var residentRaceController = TextEditingController();
  var residentNationalityController = TextEditingController();
  var residentContactController = TextEditingController();
  var residentRelatedToController = TextEditingController();
  var residentPassportController = TextEditingController();

  String? validationMessage = '';
  bool isValidate = false;
  List<HouseHoldVO> householdList = [];

  String? registrationDate;
  String? moveInDate;
  String? ownerDate;
  String? residentDate;

  bool isLoading = false;
  bool isDisposed = false;
  ResidentDataObject? owner;
  List<ResidentDataObject> residents = [];

  final Map<String, dynamic> jsonData = json.decode(kJsonString);
  final List<String> stateRegionCodes = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
  ];
  List<NRCData> _townships = [];
  List<String> selectedTownshipCodes = [];
  // Define selected values
  String? selectedStateRegionCode;
  String? selectedTownshipCode;
  String? selectedNRCType;

  final TmsModel _tmsModel = TmsModelImpl();

  HouseHoldBloc(this.context) {
    var token = PersistenceData.shared.getToken();
    getHouseHoldLists(token);
    registrationDate = DateFormatter.formatDate(DateTime.now());
    moveInDate = DateFormatter.formatDate(DateTime.now());
    ownerDate = DateFormatter.formatDate(DateTime.now());
    residentDate = DateFormatter.formatDate(DateTime.now());
    final nrcResponse = NRCResponse.fromJson(jsonData);
    _townships = nrcResponse.data;
  }

  getTownshipByRegionCode(String code) {
    selectedStateRegionCode = code;
    selectedTownshipCodes = _townships
        .where((data) => data.nrcCode == code) // Filter by nrcCode
        .map((data) => data.nameEn) // Extract nameEn
        .toList();
    notifyListeners();
  }

  onChangeStateCode(String value) {
    selectedStateRegionCode = value;
    notifyListeners();
  }

  onChangeTownship(String value) {
    selectedTownshipCode = value;
    notifyListeners();
  }

  onChangeType(String value) {
    selectedNRCType = value;
    notifyListeners();
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

  onSelectOwnerGender(String value){
    ownerGender = value;
    notifyListeners();
  }

  onChangeNRC() {
    notifyListeners();
  }

  changeExpansion() {
    notifyListeners();
  }

  checkValidation() {
    if (residentNameController.text.isEmpty) {
      validationMessage = 'Name is required!';
    } else if (residentGender == null) {
      validationMessage = 'Gender is required!';
    } else if (residentRaceController.text.isEmpty) {
      validationMessage = 'Race is required!';
    } else if (residentNationalityController.text.isEmpty) {
      validationMessage = 'Nationality is required!';
    } else if (nrc == null) {
      validationMessage = 'NRC is required!';
    } else if (residentContactController.text.isEmpty) {
      validationMessage = 'Contact Number is required!';
    } else if (residentRelatedToController.text.isEmpty) {
      validationMessage = 'Related to Owner is required!';
    } else {
      isValidate = true;
    }
    notifyListeners();
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
                ownerDate = DateFormatter.formatDate(value);
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
