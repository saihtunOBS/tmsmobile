import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';

class ChangeProfileBloc extends ChangeNotifier {
  bool isUploadImage = false;
  File? imgFile;
  var token = '';
  bool isLoading = false;
  bool isDisposed = false;

  final TmsModel _tmsModel = TmsModelImpl();

  ChangeProfileBloc() {
    token = PersistenceData.shared.getToken();
  }

  void selectImage(int type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
        source: ImageSource.values[type],);
    if (img == null) return;
    _showLoading();
    imgFile = File(img.path);
    _tmsModel.updateProfile(token, imgFile!).whenComplete(() => _hideLoading());
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
