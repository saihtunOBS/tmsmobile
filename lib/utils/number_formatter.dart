import 'package:intl/intl.dart';

String numberFormatter(String number) {
  return NumberFormat('#,###').format(number);
}
