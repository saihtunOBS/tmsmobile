import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';

class LanguageBloc with ChangeNotifier {
  BuildContext? context;
  final Locale _mmLocale = Locale('my', 'MM');
  final Locale _enLocale = Locale('en', 'US');

  LanguageBloc({this.context}) {
    setLocale();
  }

  void setLocale() {
    PersistenceData.shared.getLocale() == null ||
            PersistenceData.shared.getLocale() == 'en_US'
        ? context?.setLocale(_enLocale)
        : context?.setLocale(_mmLocale);
    notifyListeners();
  }
}
