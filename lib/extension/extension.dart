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