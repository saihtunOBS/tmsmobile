import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension Gap on num {
  SizedBox get vGap => SizedBox(height: toDouble());
  SizedBox get hGap => SizedBox(width: toDouble());
}

extension DateFormatting on DateTime {
  String toFormattedString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}

extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsNumber => contains(RegExp(r'[0-9]'));
  bool get moreThan8Character => length > 8;
  bool get containsSpecialCharacter => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
}