import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';

class ContractInformationBloc extends ChangeNotifier {
  ContractInformationVO? contract;
  bool isLoading = false;
  bool isDisposed = false;
  String? id;
  final TmsModel _tmsModel = TmsModelImpl();

  ContractInformationBloc(this.id) {
    var token = PersistenceData.shared.getToken();
    _showLoading();
    _tmsModel
        .getContractInformation(token, id ?? '')
        .then((response) => contract = response)
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
