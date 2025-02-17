import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/network/requests/maintenance_status_request.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class MaintenanceQuotationBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  String? id;
  String? token;
  final TmsModel _tmsModel = TmsModelImpl();

  MaintenanceQuotationBloc(this.id) {
    token = PersistenceData.shared.getToken();
  }

  Future changeStatus(bool isReject) {
    _showLoading();
    var request = MaintenanceStatusRequest(isReject == true ? 4 : 5);
    return _tmsModel
        .changeMaintenanceStatus(token ?? '', id ?? '', request)
        .whenComplete(() => _hideLoading());
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
