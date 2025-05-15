import 'package:get_storage/get_storage.dart';
import 'package:tmsmobile/data/vos/login_data_vo.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';

enum PersistenceList { loginUser, locale, isFirstTime, token, userData, tenant }

class PersistenceData {
  static var shared = PersistenceData();

  saveFirstTime(bool? isFirstTime) async {
    await GetStorage().write(PersistenceList.isFirstTime.name, isFirstTime);
  }

  saveToken(String token) async {
    await GetStorage().write(PersistenceList.token.name, token);
  }

  saveLocale(String locale) async {
    await GetStorage().write(PersistenceList.locale.name, locale);
  }

  saveUserData(UserVO userdata) async {
    Map<String, dynamic> user = userdata.toJson();
    await GetStorage().write(PersistenceList.userData.name, user);
  }

  /// get...

  getFirstTimeStatus() {
    return GetStorage().read(PersistenceList.isFirstTime.name);
  }

  getToken() {
    return GetStorage().read(PersistenceList.token.name);
  }

  UserVO? getUser() {
    final userJson = GetStorage().read<Map<String, dynamic>>(
        PersistenceList.userData.name); // Read JSON map
    if (userJson != null) {
      return UserVO.fromJson(userJson); // Convert back to UserVO
    }
    return null; // Return null if no user is found
  }

  LoginDataVO getLoginResponse() {
    return GetStorage().read(PersistenceList.loginUser.name);
  }

  getLocale() {
    return GetStorage().read(PersistenceList.locale.name);
  }

  clearToken() async {
    await saveToken('');
    await GetStorage().remove(PersistenceList.token.name);
  }

  clearUserData() {
    GetStorage().remove(PersistenceList.userData.name);
  }
}
