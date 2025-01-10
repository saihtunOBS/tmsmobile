import 'dart:io';

import 'package:dio/dio.dart';
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
  String? filloutValidationMessage;
  bool isLoading = false;
  bool isDisposed = false;

  final TmsModel _tmsModel = TmsModelImpl();

  MaintenanceBloc({this.tenant}) {
    token = PersistenceData.shared.getToken();
  }

  onTapSendRequest() async {
    _showLoading();
    List<MultipartFile> files = await Future.wait(imageArray
        .map((photo) async => await MultipartFile.fromFile(photo.path))
        .toList());
    _tmsModel
        .createFillOut(token ?? '', files, tenant?.id ?? '',
            selectedRoomShopName?.id ?? '', description ?? '')
        .whenComplete(() => _hideLoading());
  }

  void selectImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg'],
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
      filloutValidationMessage = 'Please select Room/Shop Name';
    } else if (imageArray.isEmpty) {
      filloutValidationMessage = 'Please upload at least image';
    } else {
      filloutValidationMessage = 'success';
    }
    notifyListeners();
  }

  onTapRoomShopName(Shop value) {
    selectedRoomShopName = value;
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
