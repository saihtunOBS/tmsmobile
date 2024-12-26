import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MaintenanceBloc extends ChangeNotifier {
  List<File> imageArray = [];
  bool isUploadImage = false;

  void selectImage() async {
    final imagePicker = ImagePicker();
    try {
      if (imageArray.length == 1) {
        final XFile? selectedImage =
            await imagePicker.pickImage(source: ImageSource.gallery);
        imageArray.add(File(selectedImage?.path ?? ''));
        notifyListeners();
      } else {
        final List<XFile> selectedImages =
            await imagePicker.pickMultiImage(limit: 2);
        if (selectedImages.isNotEmpty) {
          for (var image in selectedImages) {
            imageArray.add(File(image.path));
          }
        }
        notifyListeners();
      }
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
