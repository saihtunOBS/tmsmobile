import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ChangeProfileBloc extends ChangeNotifier {
  bool isUploadImage = false;
  File? imgFile;

  void selectImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg'],
      );
      if (result != null) {
        imgFile = (File(result.paths.first ?? ''));
      }

      notifyListeners();
    } catch (e) {
      ///
    }
  }
}
