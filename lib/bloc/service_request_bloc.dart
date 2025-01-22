import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';

class ServiceRequestBloc extends ChangeNotifier {
  String? token;
  List<ServiceRequestVo> fillOutLists = [];
  List<ServiceRequestVo> maintenanceLists = [];
  bool isLoading = false;
  bool isDisposed = false;
  List<Shop>? filloutShops;
  List<Shop>? maintenanceShops;

  int filloutPage = 1;
  bool isLoadMoreFillOut = false;

  int maintenancePage = 1;
  bool isLoadMoreMaintenance = false;

  final TmsModel _tmsModel = TmsModelImpl();

  ServiceRequestBloc() {
    token = PersistenceData.shared.getToken();
    getMaintenances();
    getFillOuts();
  }

  getFillOuts() {
    _showLoading();
    filloutPage = 1;
    _tmsModel.getFillOuts(token ?? '', filloutPage, 10).then((response) {
      fillOutLists = response;
      filloutShops = response.map((data) => data.shop as Shop).toList();
    }).whenComplete(() => _hideLoading());
  }

  getMaintenances() {
    _showLoading();
    _tmsModel.getMaintenances(token ?? '').then((response) {
      maintenanceLists = response;
      maintenanceShops = response.map((data) => data.shop as Shop).toList();
    }).whenComplete(() => _hideLoading());
  }

  getLoadMoreFillOuts() {
    if (isLoadMoreFillOut) return;
    isLoadMoreFillOut = true;
    notifyListeners();

    filloutPage += 1;
    _tmsModel.getFillOuts(token ?? '', filloutPage, 10).then((response) {
      fillOutLists.addAll(response);
      filloutShops?.addAll(response.map((data) => data.shop as Shop).toList());
    }).whenComplete(() {
      isLoadMoreFillOut = false;
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
