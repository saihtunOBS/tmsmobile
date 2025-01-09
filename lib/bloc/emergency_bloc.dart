import 'package:flutter/cupertino.dart';

class EmergencyBloc extends ChangeNotifier {
  int selectedExpensionIndex = -1;

  onTapExpansion() {
    notifyListeners();
  }
}
