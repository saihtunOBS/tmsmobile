import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/responses/login_response.dart';

import '../../network/requests/change_password_request.dart';
import '../../network/requests/login_request.dart';
import '../vos/household_vo.dart';

abstract class TmsModel {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future changePassword(ChangePasswordRequest changePasswordRequest);
  Future<UserVO> getUser(String token);
  Future<List<HouseHoldVO>> getHouseHoldList(String token);
}