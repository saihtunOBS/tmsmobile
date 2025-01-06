import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/resident_vo.dart';

import '../data/vos/household_vo.dart';

class EditResidentBloc extends ChangeNotifier {
  List<ResidentVo> residentVo = [];
  DateTime selectedDate = DateTime.now();
  BuildContext? context;
  String? nrc;
  int selectedExpensionIndex = -1;
  String? gender;

  var residentNameController = TextEditingController();
  var residentRaceController = TextEditingController();
  var residentNationalityController = TextEditingController();
  var residentContactController = TextEditingController();
  var residentRelatedToController = TextEditingController();

  String? validationMessage = '';
  bool isValidate = false;
  HouseHoldVO? houseHoldData;

  EditResidentBloc(this.context,this.houseHoldData) {
    // residentNameController.text = house
  }

  addResident({required ResidentVo resident}) {
    residentVo.add(resident);
    gender = null;
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

  onSelectGender() {
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
    } else if (gender == null) {
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
