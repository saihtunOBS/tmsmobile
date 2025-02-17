import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/network/responses/epc_response.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class EpcBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  final TmsModel _tmsModel = TmsModelImpl();
  BuildContext? context;
  EpcResponse? epcResponse;
  String? token;

  EpcBloc({this.context}) {
    token = PersistenceData.shared.getToken();
    getEpc();
  }

  getEpc() {
    _showLoading();
    _tmsModel.getEpcResponse(token ?? '').then((response) {
      epcResponse = response;
      print(epcResponse?.data?.first);
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
