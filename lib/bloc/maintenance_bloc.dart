import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class MaintenanceBloc extends ChangeNotifier {
  List<File> imageArray = [];
  bool isUploadImage = false;

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

  void onTapUploadFile() {
    isUploadImage = !isUploadImage;
    notifyListeners();
  }

  void removeImage({required int index}) {
    imageArray.removeAt(index);
    notifyListeners();
  }
}
