import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class BillingBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  bool showPassword = false;
  List<BillingVO> billingLists = [];
  List<BillingVO> originalBillingLists = [];
  String? token;
  String? selectedOption = 'All';

  final TmsModel _tmsModel = TmsModelImpl();

  BillingBloc() {
    token = PersistenceData.shared.getToken();
    getBilling();
  }

  getBilling({String? type}) {
    _showLoading();
    _tmsModel.getBillingLists(token ?? '').then((response) {
      type == 'Paid'
          ? billingLists = response.where((value) => value.status == 1).toList()
          : type == 'Unpaid'
              ? billingLists =
                  response.where((value) => value.status == 0).toList()
              : billingLists = response;
      originalBillingLists = response;
    }).whenComplete(() => _hideLoading());
  }

  onChangeDropDown(value) {
    selectedOption = value;
    billingLists = originalBillingLists;

    if (value == 'Unpaid') {
      billingLists = billingLists.where((value) => value.status == 0).toList();
    } else if (value == 'Paid') {
      billingLists = billingLists.where((value) => value.status == 2).toList();
    }
    notifyListeners();
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
