import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/pending_vo.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class MaintenanceProcessBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  bool showPassword = false;
  final TmsModel _tmsModel = TmsModelImpl();
  final String? id;
  String? pendingDate;
  String? surveyDate;
  String? quotationDate;
  String? acceptRejectDate;
  String? processingDate;
  String? finishedDate;
  PendingVO? pendingVO;

  MaintenanceProcessBloc(this.id) {
    var token = PersistenceData.shared.getToken();
    getMaintenanceProcess(token);
  }

  getMaintenanceProcess(token) {
    _showLoading();
    _tmsModel.getMaintenanceProcess(token, id ?? '').then((response) {
      
      try {
        pendingVO = response.data?.first.pending;
        pendingDate = response.data?.first.pending?.pendingDate ?? '';
        surveyDate = response.data?[1].survey?.surveyDate ?? '';
        quotationDate = '8/8/2025';
        acceptRejectDate =
            response.data?[3].acceptReject?.acceptRejectDate ?? '';
        processingDate = response.data?[4].processing?.processingDate ?? '';
        finishedDate = response.data?[5].finished?.finishedDate ?? '';
      } catch (e) {
        ///
      }

      notifyListeners();
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
