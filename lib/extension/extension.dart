import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool get moreThan8Character => length >= 8;
  bool get containsSpecialCharacter =>
      contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
