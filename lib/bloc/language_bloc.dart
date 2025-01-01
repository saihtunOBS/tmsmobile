import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

StreamController<String> languageStreamController = BehaviorSubject<String>();

class LanguageBloc extends ChangeNotifier {
  Locale locale = Locale('my', 'MM');

  Locale get getLocale => locale;

  LanguageBloc() {
    updateLocale();
  }
  void updateLocale({Locale? newLocale}) {
    locale = newLocale ?? locale;
    notifyListeners();
  }
}
