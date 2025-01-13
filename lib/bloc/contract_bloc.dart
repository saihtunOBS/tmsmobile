import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/contract_vo.dart';

class ContractBloc extends ChangeNotifier {
  List<ContractVo> contracts = [];
  bool isLoading = false;
  bool isDisposed = false;
  int page = 1;
  bool isLoadMore = false;
  String? token;
  final TmsModel _tmsModel = TmsModelImpl();
  ContractBloc() {
    token = PersistenceData.shared.getToken();
    _showLoading();
    _tmsModel
        .getContracts(token ?? '', page, 10)
        .then((response) => contracts = response)
        .whenComplete(() => _hideLoading());
  }

  loadMoreData() {
    _showLoadMoreLoading();
    page += 1;
    _tmsModel
        .getContracts(token ?? '', page, 10)
        .then((response) => contracts.addAll(response))
        .whenComplete(() => _hideLoadMoreLoading());
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
