import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';

class ServiceRequestBloc extends ChangeNotifier {
  String? token;
  List<ServiceRequestVo> fillOutLists = [];
  bool isLoading = false;
  bool isDisposed = false;
  List<Shop>? shops;

  final TmsModel _tmsModel = TmsModelImpl();

  ServiceRequestBloc() {
    token = PersistenceData.shared.getToken();
    getFillOuts();
  }

  getFillOuts() {
    _showLoading();
    _tmsModel.getFillOuts(token ?? '', 1, 10).then((response) {
      fillOutLists = response;
      shops = response.map((data) => data.shop as Shop).toList();
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
}
