
import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy MMM d');
    String formatted = formatter.format(dateTime);

    return formatted;
  }
}
