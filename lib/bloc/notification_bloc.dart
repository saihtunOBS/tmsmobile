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
    token = PersistenceData.shared.getToken();
    getNotification();
  }

  getNotification() async {
    _showLoading();
    _tmsModel.getNotifications(token ?? '').then((response) {
      notiLists = response;
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
