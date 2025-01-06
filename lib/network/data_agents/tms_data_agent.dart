import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/requests/change_password_request.dart';

import '../requests/login_request.dart';
import '../responses/login_response.dart';

abstract class TmsDataAgent {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future changePassword(ChangePasswordRequest changePasswordRequest);
  Future<UserVO> getUser(String token);
  Future<List<HouseHoldVO>> getHouseHoldList(String token);
}