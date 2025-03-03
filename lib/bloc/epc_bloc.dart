import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/network/notification_service.dart';
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
    updateToken();
  }

  void updateToken() {
    token = PersistenceData.shared.getToken();
    notifyListeners();
  }

  getEpc() async {
    _showLoading();
    await _tmsModel.getEpcResponse(token ?? '').then((response) {
      epcResponse = response;
      if (response.data?.isEmpty ?? true) {
        epcStreamController.sink.add('မီးပျက်နေပါသည်');
      } else if (response.data?.first.switchState == 0) {
        epcStreamController.sink.add('မီးပျက်နေပါသည်');
      } else {
        epcStreamController.sink.add('မီးလာနေပါသည်');
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
