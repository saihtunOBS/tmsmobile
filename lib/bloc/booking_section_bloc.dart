import 'package:flutter/material.dart';

List<String> sheetFromTimeArray = [];
List<String> sheetToTimeArray = [];
List<String> sectionFromTimeArray = [];
List<String> sectionToTimeArray = [];

class BookingSectionBloc extends ChangeNotifier {
  bool isOpenDate = true;
  bool isSectionView = false;
  bool isReserveView = false;
  bool isLoading = true;
  bool isSelectFromDate = true;
  DateTime? userSelectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();
  List<DateTime?> selectedDate = [null];

  BookingSectionBloc() {
    sectionFromTimeArray.clear();
    sectionToTimeArray.clear();
    sheetFromTimeArray = ['9:00 AM', '12:00 PM', '3:00 PM'];
    sheetToTimeArray = ['12:00 PM', '3:00 PM', '6:00 PM'];
  }

  onChangeDate(List<DateTime> date) {
    selectedDate = date;
    isOpenDate = false;
    isSectionView = true;
    notifyListeners();
  }

  onSelectSection(String fromTime, String toTime) {
    isSectionView = false;
    isReserveView = true;
    sectionFromTimeArray.add(fromTime);
    sectionToTimeArray.add(toTime);

    sheetFromTimeArray.removeWhere((item) => item == fromTime);
    sheetToTimeArray.removeWhere((item) => item == toTime);

    notifyListeners();
  }
}
