import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/notification_vo.dart';

class NotificationBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  bool isLoadMore = false;
  String? token;
  final TmsModel _tmsModel = TmsModelImpl();
  List<NotificationVO> notiLists = [];

  NotificationBloc() {
    updateToken();
  }

  void updateToken() {
    token = PersistenceData.shared.getToken();
    notifyListeners();
  }

  getNotification() async {
    _showLoading();
    await _tmsModel.getNotifications(token ?? '').then((response) {
      notiLists = response
          .toSet()
          .toList()
          .where((item) =>
              response.indexWhere((element) =>
                  element.referenceData?.id == item.referenceData?.id) ==
              response.indexOf(item))
          .toList();
      _hideLoading();
    }).whenComplete(() => _hideLoading());
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
