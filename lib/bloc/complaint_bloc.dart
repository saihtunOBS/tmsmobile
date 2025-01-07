import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';
import 'package:tmsmobile/network/requests/complaint_request.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class ComplaintBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isSubmitLoading = false;
  bool isDisposed = false;
  var token = '';

  final TmsModel _tmsModel = TmsModelImpl();
  List<ComplaintVO> pendingComplainList = [];
  List<ComplaintVO> solvedComplainList = [];

  String? complaintId;
  ComplaintVO? complaintDetail;

  ComplaintBloc({this.complaintId, bool? isDetail}) {
    token = PersistenceData.shared.getToken();
    getComplaint();

    if (isDetail == true) {
      getComplaintDetails(complaintId);
    }
  }

  Future createComplaint(String value) {
    _showSubmitLoading();
    var request = ComplaintRequest(value);
    return _tmsModel.createComplaint(token, request).whenComplete(() {
      _hideSubmitLoading();
      notifyListeners();
    });
  }

  getComplaintDetails(id) {
    _showLoading();
    _tmsModel.getComplaintDetails(token, id).then((value) {
      complaintDetail = value;
    }).whenComplete(() {
      _hideLoading();
      notifyListeners();
    });
  }

  _showSubmitLoading() {
    isSubmitLoading = true;
    _notifySafely();
  }

  _hideSubmitLoading() {
    isSubmitLoading = false;
    _notifySafely();
  }

  getComplaint() {
    _showLoading();
    _tmsModel.getComplaints(token).then((data) {
      pendingComplainList = data.where((value) => value.status == 1).toList();
      solvedComplainList = data.where((value) => value.status == 2).toList();
    }).whenComplete(() => _hideLoading());
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
