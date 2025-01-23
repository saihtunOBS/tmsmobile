import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/login_page.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class ProfileBloc extends ChangeNotifier {
  String? token;
  UserVO? userData;
  bool isLoading = false;
  bool isDisposed = false;
  final TmsModel _tmsModel = TmsModelImpl();
  BuildContext? context;

  ProfileBloc({this.context}) {
    token = PersistenceData.shared.getToken();
    getUser();
  }

  getUser() {
    _tmsModel.getUser(token ?? '').then((response) {
      userData = response.data;
      notifyListeners();
    }).catchError((error) {
      if (error.toString().contains('Authentication failed!')) {
        PersistenceData.shared.clearToken();
        PageNavigator(ctx: context).nextPageOnly(page: LoginPage());
      }
    });
  }

  Future onTapDelete() {
    _showLoading();
    return _tmsModel.deleteUser(token ?? '').whenComplete(() => _hideLoading());
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
}
