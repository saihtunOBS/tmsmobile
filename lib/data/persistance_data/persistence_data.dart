import 'package:get_storage/get_storage.dart';

enum PersistenceList {
  isFirstTime,
  token,
  fCMToken,
  isAlreadyLogin,
  isSignedIn,
  authToken,
  accessToken
}

class PersistenceData {
  static var shared = PersistenceData();

  saveAuthStatus(String status) async {
    await GetStorage().write(PersistenceList.isSignedIn.name, status);
  }

  saveFcmToken(String token) async {
    await GetStorage().write(PersistenceList.fCMToken.name, token);
  }

  saveAccessToken(String status) async {
    await GetStorage().write(PersistenceList.accessToken.name, status);
  }

  saveIsFirstTime(bool? isFirstTime) async {
    await GetStorage()
        .write(PersistenceList.isFirstTime.name, isFirstTime ?? true);
  }

/// get...

  getFirstTimeStatus() {
    return GetStorage().read(PersistenceList.isFirstTime.name);
  }

  getAuthStatus() {
    return GetStorage().read(PersistenceList.isSignedIn.name);
  }

  getAccessToken() {
    return GetStorage().read(PersistenceList.accessToken.name);
  }

  getFcmToken() {
    return GetStorage().read(PersistenceList.fCMToken.name);
  }
}
