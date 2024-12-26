import 'package:flutter/cupertino.dart';

class ChangePasswordBloc extends ChangeNotifier {
  bool isMore8character = false;
  bool isUpperCaseContain = false;
  bool isNumberContain = false;
  bool isSpecialNumberContain = false;
}