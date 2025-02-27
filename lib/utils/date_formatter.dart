import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-d');
    String formatted = formatter.format(dateTime);

    return formatted;
  }

  static DateTime stringToDate(String date) {
    DateFormat format = DateFormat("MMM dd,yyyy"); // Define the format
    DateTime parsedDate = format.parse(date);
    return parsedDate;
  }

  static String formatDate2(DateTime dateTime) {
    DateFormat formatter = DateFormat('MMM dd,yyyy');
    String formatted = formatter.format(dateTime);

    return formatted;
  }

  // static String formatStringDate(String date) {
  //   try {
  //     final formatter = DateFormat('EEE MMM d yyyy HH:mm:ss');
  //     final dateTime = formatter.parse(date);
  //     return formatDate(dateTime);
  //   } catch (e) {
  //     return ""; // Handle errors
  //   }
  // }

  static String formatStringDate(String date) {
    try {
      final formatter = DateFormat('EEE MMM d yyyy HH:mm:ss');
      final dateTime = formatter.parse(date);

      // Format the date to 'MMM dd, yyyy'
      return DateFormat('MMM dd, yyyy').format(dateTime);
    } catch (e) {
      return ""; // Handle errors
    }
  }
}
