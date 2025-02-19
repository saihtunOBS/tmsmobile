import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/network/requests/login_request.dart';
import 'package:tmsmobile/network/responses/login_response.dart';

class LogInBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  bool showPassword = false;
  final TmsModel _tmsModel = TmsModelImpl();
  bool isAgreeTermAndCondition = false;

  LogInBloc() {
    if (PersistenceData.shared.getFirstTimeStatus() == false) {
      isAgreeTermAndCondition = true;
    }
  }

  Future<LoginResponse> onTapSignIn(String phone, password) async {
    _showLoading();
    var fcmToken = await FirebaseMessaging.instance.getToken();
    var loginRequest = LoginRequest(phone, password, fcmToken);
    return _tmsModel.login(loginRequest).whenComplete(() => _hideLoading());
  }

  _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  onTapShowPassword() {
    showPassword = !showPassword;
    _notifySafely();
  }

  _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  onCheckTermAndConditon(bool value) {
    isAgreeTermAndCondition = value;
    notifyListeners();
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
