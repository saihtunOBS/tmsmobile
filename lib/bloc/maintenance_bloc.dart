import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';

class MaintenanceBloc extends ChangeNotifier {
  List<File> imageArray = [];
  bool isUploadImage = false;
  String? token;
  Tenant? tenant;
  String? description;
  Shop? selectedRoomShopName;
  String? validationMessage;
  String? selectedIssue;
  bool isLoading = false;
  bool isDisposed = false;
  BuildContext? context;

  final TmsModel _tmsModel = TmsModelImpl();

  MaintenanceBloc({this.tenant, this.context}) {
    token = PersistenceData.shared.getToken();
  }

  Future onTapSendRequestFillOut() async {
    _showLoading();
    List<File> files = imageArray.map((photo) => File(photo.path)).toList();
    return _tmsModel
        .createFillOut(token ?? '', files, tenant?.id ?? '',
            selectedRoomShopName?.id ?? '', description ?? '')
        .whenComplete(() {
      _hideLoading();
      Navigator.pop(context!);
    });
  }

  Future onTapSendRequestMaintenance() {
    _showLoading();
    List<File> files = imageArray.map((photo) => File(photo.path)).toList();
    return _tmsModel
        .createMaintenance(
            token ?? '',
            files,
            tenant?.id ?? '',
            selectedRoomShopName?.id ?? '',
            description ?? '',
            selectedIssue ?? '')
        .whenComplete(() => Navigator.pop(context!));
  }

  void selectImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
        // allowedExtensions: ['jpg'],
      );

      if (result?.paths.first != null) {
        imageArray.add(File(result?.paths.first ?? ''));
      }
      notifyListeners();
    } catch (e) {
      ///
    }
  }

  void checkFillOutValidation() {
    if (selectedRoomShopName == null) {
      validationMessage = 'Please select Room/Shop Name';
    } else if (imageArray.isEmpty) {
      validationMessage = 'Please upload at least image';
    } else {
      validationMessage = 'success';
    }
    notifyListeners();
  }

  void checkMaintenanceValidation() {
    if (selectedRoomShopName == null) {
      validationMessage = 'Please select Room/Shop Name';
    } else if (selectedIssue == null) {
      validationMessage = 'Please select Type of issue';
    } else if (imageArray.isEmpty) {
      validationMessage = 'Please upload at least image';
    } else {
      validationMessage = 'success';
    }
    notifyListeners();
  }

  onChangeRoomShopName(Shop value) {
    selectedRoomShopName = value;
    notifyListeners();
  }

  onChangeIssue(String value) {
    selectedIssue = value;
    notifyListeners();
  }

  void onTapUploadFile() {
    isUploadImage = !isUploadImage;
    notifyListeners();
  }

  onChangeDescription(value) {
    description = value;
    notifyListeners();
  }

  void removeImage({required int index}) {
    imageArray.removeAt(index);
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
}
