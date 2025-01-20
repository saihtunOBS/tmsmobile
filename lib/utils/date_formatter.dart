
import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-d');
    String formatted = formatter.format(dateTime);

    return formatted;
  }
}
