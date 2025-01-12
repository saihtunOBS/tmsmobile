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
}
