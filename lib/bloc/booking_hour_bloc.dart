import 'package:flutter/material.dart';

import '../utils/date_formatter.dart';

class BookingHourBloc extends ChangeNotifier {
  bool isOpenDate = false;
  bool isTimeView = false;
  bool isReserveView = false;
  bool isLoading = false;
  bool isSelectFromDate = true;
  DateTime? userSelectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();
  List<DateTime?> selectedDate = [DateTime.now()];

  String fromDate = '';
  String fromTime = '';

  String toDate = '';
  String toTime = '';

  onSelectDate() {
    _showLoading();
    isOpenDate = true;
    isTimeView = false;
    isReserveView = false;
    showCurrentDate();
    notifyListeners();
    Future.delayed(Duration(milliseconds: 300), () {
      _hideLoading();
    });
  }

  onClickCancelCaneldar() {
    isOpenDate = false;
    isTimeView = false;
    isReserveView = false;
    resetDate();
    notifyListeners();
  }

  onClickCancelTime() {
    isOpenDate = false;
    isTimeView = false;
    isReserveView = false;
    notifyListeners();
  }

  onClickSelectTimeOk() {
    isTimeView = false;
    isReserveView = true;
    String period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';

    if (isSelectFromDate == true) {
      fromDate =
          DateFormatter.formatDate2(selectedDate.first ?? DateTime.now());
      fromTime = '${convertTo12HourFormat(selectedTime)} $period';
    } else {
      toDate = DateFormatter.formatDate2(selectedDate.first ?? DateTime.now());
      toTime = '${convertTo12HourFormat(selectedTime)} $period';
    }

    notifyListeners();
  }

  onSelectFromOrToDate(bool status) {
    isSelectFromDate = status;
    showCurrentDate();
    notifyListeners();
  }

  onChangeTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  onChangeDate(List<DateTime> date) {
    selectedDate = date;
    notifyListeners();
  }

  resetDate() {
    _showLoading();
    selectedDate = [DateTime.now()];
    Future.delayed(Duration(seconds: 1), () {
      _hideLoading();
    });
  }

  _showLoading() {
    isLoading = true;
    notifyListeners();
  }

  _hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  onClickOkCalendar() {
    isOpenDate = false;
    isTimeView = true;
    notifyListeners();
  }

  showCurrentDate() {
    if (isSelectFromDate == true) {
      userSelectedDate = fromDate == ''
          ? DateTime.now()
          : DateFormatter.stringToDate(fromDate);
    } else {
      userSelectedDate =
          toDate == '' ? DateTime.now() : DateFormatter.stringToDate(toDate);
    }
    updateDate();
    notifyListeners();
  }

  updateDate() {
    selectedDate = [userSelectedDate];
    notifyListeners();
  }

  String convertTo12HourFormat(TimeOfDay time) {
    int hour = time.hour;

    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    String minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}
