import 'package:get_storage/get_storage.dart';
import 'package:tmsmobile/data/vos/login_data_vo.dart';

enum PersistenceList { user, locale, isFirstTime, token }

class PersistenceData {
  static var shared = PersistenceData();

  saveFirstTime(bool? isFirstTime) async {
    await GetStorage().write(PersistenceList.isFirstTime.name, isFirstTime);
  }

  saveToken(String token) async {
    await GetStorage().write(PersistenceList.token.name, token);
  }

  Future<void> saveLoginResponse(LoginDataVO userData) async {
    // Convert LoginDataVO to a JSON map
    Map<String, dynamic> user = userData.toJson();

    // Save the JSON map to GetStorage
    await GetStorage().write(PersistenceList.user.name, user);
  }

  saveLocale(String locale) async {
    await GetStorage().write(PersistenceList.locale.name, locale);
  }

  /// get...

  getFirstTimeStatus() {
    return GetStorage().read(PersistenceList.isFirstTime.name);
  }

  getToken() {
    return GetStorage().read(PersistenceList.token.name);
  }

  Future<LoginDataVO?> getLoginResponse() async {
    // Retrieve the JSON map from GetStorage
    Map<String, dynamic>? user = GetStorage().read(PersistenceList.user.name);

    if (user != null) {
      // Convert JSON map back to LoginDataVO
      return LoginDataVO.fromJson(user);
    }
    return null; // Return null if no data is found
  }

  getLocale() {
    return GetStorage().read(PersistenceList.locale.name);
  }
}
