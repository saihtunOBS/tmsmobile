import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddResidentBloc extends ChangeNotifier {
  String? nrc;
  int selectedExpensionIndex = -1;
  String? gender;
  BuildContext? context;
  DateTime selectedDate = DateTime.now();

  AddResidentBloc(this.context){
  }

  var residentNameController = TextEditingController();
  var residentRaceController = TextEditingController();
  var residentNationalityController = TextEditingController();
  var residentContactController = TextEditingController();
  var residentRelatedToController = TextEditingController();

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
}