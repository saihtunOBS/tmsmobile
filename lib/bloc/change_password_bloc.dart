import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/network/requests/change_password_request.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class ChangePasswordBloc extends ChangeNotifier {
  bool isMore8character = false;
  bool isUpperCaseContain = false;
  bool isNumberContain = false;
  bool isSpecialNumberContain = false;

  bool isLoading = false;
  bool isDisposed = false;
  final TmsModel _tmsModel = TmsModelImpl();
  Future onTapContinue(
      {required String oldPassword, required newPassword}) async {
    _showLoading();
    var request = ChangePasswordRequest(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: newPassword);
    return _tmsModel.changePassword(request).whenComplete(() => _hideLoading());
  }

  bool checkValidationSuccess() {
    if (isMore8character == true &&
        isUpperCaseContain == true &&
        isNumberContain == true &&
        isSpecialNumberContain == true) {
      return true;
    } else {
      return false;
    }
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
