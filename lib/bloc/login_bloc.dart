import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/network/requests/login_request.dart';
import 'package:tmsmobile/network/responses/login_response.dart';

class LogInBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  bool showPassword = false;
  final TmsModel _tmsModel = TmsModelImpl();

  Future<LoginResponse> onTapSignIn(String phone, password) {
    _showLoading();
    var loginRequest = LoginRequest(phone, password);
    return _tmsModel.login(loginRequest).whenComplete(() => _hideLoading());
  }

  _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  onTapShowPassword(){
    showPassword = !showPassword;
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
