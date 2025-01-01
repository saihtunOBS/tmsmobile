import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/extension/extension.dart';

class ChangePasswordBloc extends ChangeNotifier {
  bool isMore8character = false;
  bool isUpperCaseContain = false;
  bool isNumberContain = false;
  bool isSpecialNumberContain = false;

  passwordValidation({required String passsword}) {
    if (passsword.containsUppercase) {
      isUpperCaseContain = true;
    } else {
      isUpperCaseContain = false;
    }
    if (passsword.containsNumber) {
      isNumberContain = true;
    } else {
      isNumberContain = false;
    }
    if (passsword.moreThan8Character) {
      isMore8character = true;
    } else {
      isMore8character = false;
    }
    if (passsword.containsSpecialCharacter) {
      isSpecialNumberContain = true;
    } else {
      isSpecialNumberContain = false;
    }
    notifyListeners();
  }
}
