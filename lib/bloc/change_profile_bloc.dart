import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';

class ChangeProfileBloc extends ChangeNotifier {
  bool isUploadImage = false;
  File? imgFile;
  var token = '';

  final TmsModel _tmsModel = TmsModelImpl();

  ChangeProfileBloc() {
    token = PersistenceData.shared.getToken();
  }

  void selectImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg'],
      );
      if (result != null) {
        imgFile = (File(result.paths.first ?? ''));
        _tmsModel.updateProfile(token, imgFile!);
      }

      notifyListeners();
    } catch (e) {
      ///
    }
  }
}
