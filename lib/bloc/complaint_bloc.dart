import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class ComplaintBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isSubmitLoading = false;
  bool isDisposed = false;
  var token = '';
  List<File> imageArray = [];
  bool isUploadImage = false;

  final TmsModel _tmsModel = TmsModelImpl();
  List<ComplaintVO> complainList = [];

  String? complaintId;
  ComplaintVO? complaintDetail;

  ComplaintBloc({this.complaintId, bool? isDetail}) {
    updateToken();

    if (isDetail == true) {
      updateToken();
      getComplaintDetails(complaintId);
    }
  }

  void updateToken() {
    token = PersistenceData.shared.getToken();
    notifyListeners();
  }

  Future createComplaint(String value) {
    _showSubmitLoading();
    return _tmsModel.createComplaint(token, value, imageArray).whenComplete(() {
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

  void onTapUploadFile() {
    isUploadImage = !isUploadImage;
    notifyListeners();
  }

  void removeImage({required int index}) {
    imageArray.removeAt(index);
    notifyListeners();
  }

  void selectImage(int type) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? result =
          await picker.pickImage(source: ImageSource.values[type]);
      if (result == null) return;

      imageArray.add(File(result.path));

      notifyListeners();
    } catch (e) {
      ///
    }
  }

  _showSubmitLoading() {
    isSubmitLoading = true;
    _notifySafely();
  }

  _hideSubmitLoading() {
    isSubmitLoading = false;
    _notifySafely();
  }

  onChangeTab(int status) {
    getComplaint(status);
  }

  getComplaint(int status) {
    _showLoading();
    _tmsModel.getComplaints(token, status).then((data) {
      complainList = data;
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
