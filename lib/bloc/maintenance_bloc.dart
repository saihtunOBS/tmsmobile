import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/type_of_issue_vo.dart';

import '../data/vos/room_shop_vo.dart';

class MaintenanceBloc extends ChangeNotifier {
  List<File> imageArray = [];
  bool isUploadImage = false;
  String? token;
  String? tenantId;
  String? description;
  RoomShopVO? selectedRoomShopName;
  String? validationMessage;
  String? selectedIssue;
  bool isLoading = false;
  bool isDisposed = false;
  BuildContext? context;
  List<TypeOfIssueVO> typeOfIssues = [];
  List<RoomShopVO> roomShops = [];

  final TmsModel _tmsModel = TmsModelImpl();

  MaintenanceBloc({this.context}) {
    token = PersistenceData.shared.getToken();
    tenantId = PersistenceData.shared.getUser()?.id ?? '';
    _showLoading();

    ///property list
    _tmsModel.getProperties(token ?? '').then((response) {
      roomShops = response;
    }).whenComplete(()=> _hideLoading());

    ///type of issues
    _tmsModel.getTypeOfIssues(token ?? '').then((response) {
      typeOfIssues = response;
    }).whenComplete(() => _hideLoading());
  }

  Future onTapSendRequestFillOut() async {
    _showLoading();
    List<File> files = imageArray.map((photo) => File(photo.path)).toList();
    return _tmsModel
        .createFillOut(token ?? '', files, tenantId ?? '',
            selectedRoomShopName?.shop?.id ?? '', description ?? '')
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
            tenantId ?? '',
            selectedRoomShopName?.shop?.id ?? '',
            description ?? '',
            selectedIssue ?? '')
        .whenComplete(() => Navigator.pop(context!));
  }

  void selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? result = await picker.pickImage(source: ImageSource.gallery);
      if (result == null) return;

      imageArray.add(File(result.path));

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

  onChangeRoomShopName(RoomShopVO value) {
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
