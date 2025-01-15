import 'package:flutter/widgets.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';

class ParkingBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  var token = '';
  int page = 1;
  bool isLoadMore = false;
  int selectedExpensionIndex = -1;


  List<PropertyInformation>? parkings;

  final TmsModel _tmsModel = TmsModelImpl();

  ParkingBloc() {
    token = PersistenceData.shared.getToken();
    getParking();
  }

  getParking() {
    _showLoading();
    page = 1;
    _tmsModel
        .getParking(token, 1, 10)
        .then((response) => parkings = response)
        .whenComplete(() => _hideLoading());
  }

  loadMoreData() {
    if(isLoadMore) return;
    _showLoadMoreLoading();
    page += 1;
    _tmsModel.getParking(token, page, 10).then((response) {
      parkings?.addAll(response);
    }).whenComplete(() => _hideLoadMoreLoading());
  }

  _showLoadMoreLoading() {
    isLoadMore = true;
    _notifySafely();
  }

  onTapExpansion() {
    notifyListeners();
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
