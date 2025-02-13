import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';

class ServiceRequestBloc extends ChangeNotifier {
  
  List<ServiceRequestVo> fillOutLists = [];
  List<ServiceRequestVo> maintenanceLists = [];
  bool isLoading = false;
  bool isDisposed = false;

  int filloutPage = 1;
  bool isLoadMoreFillOut = false;

  int maintenancePage = 1;
  bool isLoadMoreMaintenance = false;

  final TmsModel _tmsModel = TmsModelImpl();
  String? token;

  ServiceRequestBloc() {
    getMaintenances();
    getFillOuts();
  }

  void updateToken() {
  token = PersistenceData.shared.getToken();
  notifyListeners();
}

  getFillOuts() {
    _showLoading();
    filloutPage = 1;
    _tmsModel.getFillOuts(token ?? '', 1, 10).then((response) {
      fillOutLists = response;
    }).whenComplete(() => _hideLoading());
  }

  getMaintenances() {
    _showLoading();

    _tmsModel.getMaintenances(token ?? '', 1, 10).then((response) {
      maintenanceLists = response;
    }).whenComplete(() => _hideLoading());
  }

  getLoadMoreFillOuts() {
    if (isLoadMoreFillOut) return;
    isLoadMoreFillOut = true;
    notifyListeners();

    filloutPage += 1;
    _tmsModel.getFillOuts(token ?? '', filloutPage, 10).then((response) {
      fillOutLists.addAll(response);
    }).whenComplete(() {
      isLoadMoreFillOut = false;
      notifyListeners();
      _hideLoading();
    });
  }

  getLoadMoreMaintenance() {
    if (isLoadMoreMaintenance) return;
    isLoadMoreMaintenance = true;
    notifyListeners();

    maintenancePage += 1;
    _tmsModel
        .getMaintenances(token ?? '', maintenancePage, 10)
        .then((response) {
      maintenanceLists.addAll(response);
    }).whenComplete(() {
      isLoadMoreMaintenance = false;
      notifyListeners();
      _hideLoading();
    });
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
