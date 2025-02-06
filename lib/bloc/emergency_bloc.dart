import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/emergency_vo.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class EmergencyBloc extends ChangeNotifier {
  int selectedExpensionIndex = -1;

  bool isLoading = false;
  bool isDisposed = false;
  var token = '';
  int page = 1;
  bool isLoadMore = false;

  List<EmergencyVO> emergencyLists = [];

  final TmsModel _tmsModel = TmsModelImpl();

  EmergencyBloc() {
    token = PersistenceData.shared.getToken();
    getEmergency();
  }

  getEmergency() {
    _showLoading();
    page = 1;
    _tmsModel
        .getEmergency(token, 1, 10)
        .then((response) => emergencyLists = response)
        .whenComplete(() => _hideLoading());
  }

  loadMoreData() {
    if(isLoadMore) return;
    _showLoadMoreLoading();
    page += 1;
    _tmsModel
        .getEmergency(token, page, 10)
        .then((response) => emergencyLists.addAll(response))
        .whenComplete(() => _hideLoadMoreLoading());
  }

  onTapExpansion() {
    notifyListeners();
  }

  _showLoadMoreLoading() {
    isLoadMore = true;
    _notifySafely();
  }

  _hideLoadMoreLoading() {
    isLoadMore = false;
    _notifySafely();
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
