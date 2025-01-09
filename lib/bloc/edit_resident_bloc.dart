import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';

String? editNrcNumber;

class EditResidentBloc extends ChangeNotifier {
  int selectedExpensionIndex = -1;
  String? gender;
  BuildContext? context;
  DateTime selectedDate = DateTime.now();
  bool isValidate = false;
  String validationMessage = '';
  String? type;

  bool isLoading = false;
  bool isDisposed = false;
  HouseHoldVO? houseHoldVO;

  EditResidentBloc({this.context, this.houseHoldVO}) {
    editNrcNumber = null;
  }

  var nameController = TextEditingController();
  var raceController = TextEditingController();
  var nationalityController = TextEditingController();
  var contactController = TextEditingController();
  var relatedToController = TextEditingController();
  var emailAddressController = TextEditingController();

  setUpFormValue(){
    notifyListeners();
  }
  // _showLoading() {
  //   isLoading = true;
  //   _notifySafely();
  // }

  // _hideLoading() {
  //   isLoading = false;
  //   _notifySafely();
  // }

  // void _notifySafely() {
  //   if (!isDisposed) {
  //     notifyListeners();
  //   }
  // }

  void onChangedNrc(String nrc) {
    editNrcNumber = nrc;
    debugPrint("NewNrcNumner>>>>>>>>>>>>$editNrcNumber");
    notifyListeners();
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
