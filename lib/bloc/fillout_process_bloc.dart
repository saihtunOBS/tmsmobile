import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/network/responses/fillout_process_response.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class FilloutProcessBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  final TmsModel _tmsModel = TmsModelImpl();
  final String? id;
  DateTime? pendingDate;
  DateTime? approvedDate;
  FilloutProcessData? pendingVO;
  FilloutProcessData? approveVO;

  String? token;

  FilloutProcessBloc(this.id) {
    token = PersistenceData.shared.getToken();
    getFilloutProcess();
  }

  getFilloutProcess() {
    _showLoading();
    _tmsModel.getFilloutProcess(token ?? '', id ?? '').then((response) {
      try {
        pendingVO = response.data?.first;
        pendingDate = response.data?.first.pendingDate;
        approveVO = response.data?.length == 1
            ? FilloutProcessData()
            : response.data?[1];

        if (response.data?[1].approveDate != null) {
          response.data?[1].serviceDate ?? DateTime.now();
        }
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
