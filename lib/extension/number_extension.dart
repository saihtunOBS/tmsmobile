import 'package:intl/intl.dart';

extension NumberFormatting on String {
  String get format {
    final number = int.tryParse(this);
    if (number != null) {
      return NumberFormat('#,###').format(number);
    }
    return this;  // Return original string if it's not a valid number
  }
}