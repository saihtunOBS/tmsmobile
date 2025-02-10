import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';

class ChangeProfileBloc extends ChangeNotifier {
  bool isUploadImage = false;
  File? imgFile;
  var token = '';
  bool isLoading = false;
  bool isDisposed = false;

  final TmsModel _tmsModel = TmsModelImpl();
  UserVO? userData;

  ChangeProfileBloc() {
    token = PersistenceData.shared.getToken();
    _tmsModel.getUser(token).then((response) {
      userData = response.data ?? UserVO();
      notifyListeners();
    }).whenComplete(() => _hideLoading());
  }

  void selectImage(int type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.values[type],
    );
    if (img == null) return;

    String path = await cropImage(img);
    if (path.isEmpty) return;

    imgFile = File(path);
    _showLoading();
    _tmsModel.updateProfile(token, imgFile!).whenComplete(() {
      _tmsModel.getUser(token);
      _hideLoading();
    });
  }

  Future<String> cropImage(XFile? imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );
    return croppedFile?.path ?? '';
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

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
