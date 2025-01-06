import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/resident_vo.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';
import '../data/vos/resident_data_vo.dart';

class HouseHoldBloc extends ChangeNotifier {
  List<ResidentVo> residentVo = [];
  DateTime selectedDate = DateTime.now();
  BuildContext? context;
  String? nrc;
  int selectedExpensionIndex = -1;
  String? gender;

  var residentNameController = TextEditingController();
  var residentRaceController = TextEditingController();
  var residentNationalityController = TextEditingController();
  var residentContactController = TextEditingController();
  var residentRelatedToController = TextEditingController();

  String? validationMessage = '';
  bool isValidate = false;
  List<HouseHoldVO> householdList = [];

  bool isLoading = false;
  bool isDisposed = false;
  ResidentDataObject? owner;
  List<ResidentDataObject> residents = [];

  final TmsModel _tmsModel = TmsModelImpl();

  HouseHoldBloc(this.context) {
    var token = PersistenceData.shared.getToken();
    getHouseHoldLists(token);
  }

  getHouseHoldLists(token) {
    _showLoading();
    _tmsModel.getHouseHoldList(token).then((response) {
      householdList = response;

      // owner = ResidentDataObject(
      //     'Owner',
      //     response.first.owner?.ownerName,
      //     response.first.owner?.gender,
      //     DateFormatter.formatDate(
      //         response.first.owner?.dateOfBirth as DateTime),
      //     response.first.owner?.race,
      //     response.first.owner?.nationality,
      //     response.first.owner?.nrc,
      //     response.first.owner?.contactNumber,
      //     '-',
      //     '-');
      // for (ResidentVO resident in response.first.resident ?? []) {
      //   residents.add(ResidentDataObject(
      //       'Owner',
      //       resident.residentName,
      //       resident.gender,
      //       DateFormatter.formatDate(resident.dateOfBirth as DateTime),
      //       resident.race,
      //       resident.nationality,
      //       resident.nrc,
      //       resident.contactNumber,
      //       '-',
      //       '-'));
      // }

      // print('length....${residents.length}');

      // residents.first = owner;

      _hideLoading();
    });
    notifyListeners();
  }

  addResident({required ResidentVo resident}) {
    residentVo.add(resident);
    gender = null;
    residentNameController.clear();
    residentRaceController.clear();
    residentNationalityController.clear();
    residentContactController.clear();
    residentRelatedToController.clear();

    notifyListeners();
  }

  removeResident({required int index}) {
    residentVo.removeAt(index);
    selectedExpensionIndex = -1;
    notifyListeners();
  }

  onSelectGender() {
    notifyListeners();
  }

  onChangeNRC() {
    notifyListeners();
  }

  changeExpansion() {
    notifyListeners();
  }

  checkValidation() {
    if (residentNameController.text.isEmpty) {
      validationMessage = 'Name is required!';
    } else if (gender == null) {
      validationMessage = 'Gender is required!';
    } else if (residentRaceController.text.isEmpty) {
      validationMessage = 'Race is required!';
    } else if (residentNationalityController.text.isEmpty) {
      validationMessage = 'Nationality is required!';
    } else if (nrc == null) {
      validationMessage = 'NRC is required!';
    } else if (residentContactController.text.isEmpty) {
      validationMessage = 'Contact Number is required!';
    } else if (residentRelatedToController.text.isEmpty) {
      validationMessage = 'Related to Owner is required!';
    } else {
      isValidate = true;
    }
    notifyListeners();
  }

  Future<void> showDate() async {
    await showCupertinoModalPopup<void>(
      context: context!,
      builder: (_) {
        final size = MediaQuery.of(context!).size;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          height: size.height * 0.27,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              selectedDate = value;
              notifyListeners();
            },
          ),
        );
      },
    );
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

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
