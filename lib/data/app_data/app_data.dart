import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';

class AppData {
  static var shared = AppData();
  var appName = 'TMS Mobile';
  var appVersion = '1.0.0';
  var fontFamily = 'app_font';
  var fontFamily2 = 'crimson';
  var fontFamily3 = 'mm_font';

  String getLocaleFont() {
    if (PersistenceData.shared.getLocale() == 'my') {
      return fontFamily3;
    } else {
      return fontFamily;
    }
  }

  double getExtraFontSize() {
    if (PersistenceData.shared.getLocale() == 'my') {
      return 20;
    } else {
      return 24;
    }
  }

  double getRegularFontSize() {
    if (PersistenceData.shared.getLocale() == 'my') {
      return 17;
    } else {
      return 18;
    }
  }

  double getSmallFontSize() {
    if (PersistenceData.shared.getLocale() == 'my') {
      return 15;
    } else {
      return 16;
    }
  }

  double getSmallXFontSize() {
    if (PersistenceData.shared.getLocale() == 'my') {
      return 13;
    } else {
      return 14;
    }
  }

  double getMediumFontSize() {
    if (PersistenceData.shared.getLocale() == 'my') {
      return 18;
    } else {
      return 20;
    }
  }

  bool hasNotch(BuildContext context) {
    return MediaQuery.of(context).viewPadding.top > 0;
  }
}
