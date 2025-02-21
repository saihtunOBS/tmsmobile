import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('MMM-d-yyyy');
    String formatted = formatter.format(dateTime);

    return formatted;
  }

  static String formatStringDate(String date) {
    try {
      final formatter = DateFormat('EEE MMM d yyyy HH:mm:ss');
      final dateTime = formatter.parse(date);

      return formatDate(dateTime);
    } catch (e) {
      return ""; // Handle errors
    }
  }
}
