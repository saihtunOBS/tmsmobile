import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';

class MaintenanceBloc extends ChangeNotifier {
  List<Asset> imageArray = [];
  bool isUploadImage = false;

  void selectImage() async {
    try {
      var resultList = await MultiImagePicker.pickImages(
          selectedAssets: imageArray,
          androidOptions: AndroidOptions(
              maxImages: imageArray.isEmpty ? 2 : 1,
              hasCameraInPickerPage: true),
          iosOptions: IOSOptions(
              settings: CupertinoSettings(
                  selection:
                      SelectionSetting(max:  2))));
      imageArray = resultList;
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
