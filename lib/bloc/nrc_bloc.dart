import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/responses/nrc_response.dart';
import '../utils/json_string.dart';

class NRCBloc extends ChangeNotifier {
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
  bool isEmptyNrc = true;
  bool isNrcSelectLoading = false;
  String? nrcNumber;
  bool isLoading = false;
  bool isDisposed = false;

  NRCBloc() {
    final nrcResponse = NRCResponse.fromJson(jsonData);
    nrcNumber = null;
    _townships = nrcResponse.data;
  }

  var residentNameController = TextEditingController();
  var residentRaceController = TextEditingController();
  var residentNationalityController = TextEditingController();
  var residentContactController = TextEditingController();
  var residentRelatedToController = TextEditingController();

  getTownshipByRegionCode(String code) {
    isNrcLoading();
    selectedStateRegionCode = code;
    selectedTownshipCodes = _townships
        .where((data) => data.nrcCode == code) // Filter by nrcCode
        .map((data) => data.nameEn) // Extract nameEn
        .toList();
    selectedTownshipCode = selectedTownshipCodes.first;
    isNrcHideLoading();
  }

  onChangeStateCode(String value) {
    selectedStateRegionCode = value;
    notifyListeners();
  }

  onChangeTownship(String value) {
    selectedTownshipCode = value;
    notifyListeners();
  }

  isNrcLoading() {
    isNrcSelectLoading = true;
    notifyListeners();
  }

  isNrcHideLoading() {
    isNrcSelectLoading = false;
    notifyListeners();
  }

  onChangeType(String value) {
    selectedNRCType = value;
    notifyListeners();
  }

  onTapConfirm(String nrc) {
    nrcNumber = nrc;
    selectedTownshipCodes = [];
    selectedStateRegionCode = null;
    selectedNRCType = null;
   notifyListeners();
  }

  onChangeNrcNumber(String value) {
    value.isEmpty ? isEmptyNrc = true : isEmptyNrc = false;
    notifyListeners();
  }
}
