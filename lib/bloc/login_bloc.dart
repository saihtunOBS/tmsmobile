import 'package:flutter/material.dart';

class LoginBloc extends ChangeNotifier {
  bool isLoading = false;

  onTapSignIn() {
    _showLoading();
  }

  _showLoading() {
    isLoading = true;
    notifyListeners();
  }

  _hideLoading() {
    isLoading = false;
    notifyListeners();
  }
}
